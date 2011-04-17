package NetStack;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib ".";

use NetStack::Ethernet;
use NetStack::ARP;
use NetStack::IP;
use NetStack::ICMP;
use NetStack::TCP;
use NetStack::UDP;

use AnyEvent;

use Packet::ICMP qw/ :types /;
use Packet::Lookup qw/ :mac :ip /;

use TunTap;

my $ETH_TYPE_ARP = &Packet::Definitions::ETHERTYPE_ARP;
my $ETH_TYPE_IP = &Packet::Definitions::ETHERTYPE_IP;

$|=1;

# Config params:
#  Device
#  Netmask
#  Gateway
#  Process list {
#    protocol,
#    port,
#    callback}
#

sub new {
    my ($class, @args) = @_;
    
    # User needs to set these parameters
    my $self = {
	my_mac => "ff:ff:ff:ff:ff:ff",
	my_ip  => "192.168.56.1",
	device => "tap0",
	netmask => "255.255.255.0",
	default => "192.168.56.1",
	fh => "",
	arp_cache => {},
	stdout => [],
	task => [],
	# Will overwrite any of the default values with the user's
	@args
    };

    bless($self, $class);

    $self->initialize();

    return $self;
}

sub initialize {
    my ($self) = @_;
    
    $self->{eth} = NetStack::Ethernet->new(
	arp_cache => $self->{arp_cache},
	my_mac => $self->{my_mac},
	default => $self->{default},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	);
    
    $self->{arp} = NetStack::ARP->new(
	my_mac => $self->{my_mac},
	my_ip => $self->{my_ip},
	arp_cache => $self->{arp_cache},
	arp_up => $self->{eth}->{arp_up},
	eth_down => $self->{eth}->{eth_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	);
    
    $self->{ip} = NetStack::IP->new(
	my_ip => $self->{my_ip},
	ip_up => $self->{eth}->{ip_up},
	eth_down => $self->{eth}->{eth_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	);
    
    $self->{tcp} = NetStack::TCP->new(
	tcp_up => $self->{ip}->{tcp_up},
	ip_down => $self->{ip}->{ip_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	);

    $self->{udp} = NetStack::UDP->new(
	udp_up => $self->{ip}->{udp_up},
	ip_down => $self->{ip}->{ip_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	);
    
    $self->{icmp} = NetStack::ICMP->new(
	icmp_up => $self->{ip}->{icmp_up},
	ip_down => $self->{ip}->{ip_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	);
    
    # Link process references with anonymous subroutines
    $self->{eth}->{tap_p} = sub {$self->send_tap()};
    $self->{eth}->{arp_p} = sub {$self->{arp}->process_up()};
    $self->{eth}->{ip_p} = sub {$self->{ip}->process_up()};
    
    $self->{arp}->{eth_p} = sub {$self->{eth}->process_down()};
    
    $self->{ip}->{eth_p} = sub {$self->{eth}->process_down()};
    $self->{ip}->{icmp_p} = sub {$self->{icmp}->process_up()};
    $self->{ip}->{tcp_p} = sub {$self->{tcp}->process_up()};
    $self->{ip}->{udp_p} = sub {$self->{udp}->process_up()};
    
    $self->{tcp}->{ip_p} = sub {$self->{ip}->process_down()};

    $self->{udp}->{ip_p} = sub {$self->{ip}->process_down()};

    $self->{icmp}->{ip_p} = sub {$self->{ip}->process_down()};
    
}

sub run {
    my ($self) = @_;
        
    $self->{fh} = TunTap->attach(
	name => $self->{device}
	);
    
    print("shell: ");

    # Wair variable
    my $y_event = AnyEvent->condvar;
    
    # IO event for the Tap device
    my $tap_event = AnyEvent->io(
	fh => $self->{fh},
	poll => "r",
	cb => sub {
	    my $pkt_raw;
	    my $ret = sysread($self->{fh}, $pkt_raw, 4096);
	    if (!defined($ret)) {
		return;
	    }

	    push(@{$self->{eth}->{eth_up}}, $pkt_raw);
	    push(@{$self->{task}}, sub {$self->{eth}->process_up()});
	}
	);

    my $input_event = AnyEvent->io(
	fh => \*STDIN,
	poll => "r",
	cb => sub {
	    my $line = <>;
	    push(@{$self->{stdin}}, $line);
	    push(@{$self->{task}}, sub {$self->stdin_p()});
	}
	);
    
    # Idle process event
    my $idle_event = AnyEvent->idle(
	cb => sub {
	    my $task = shift(@{$self->{task}});
	    if (defined($task)) {
		$task->();
	    }
	}
	);
    
    $y_event->recv;

    return;	
}

sub dump_arp {
    my ($self) = @_;
    my $rtn = "";
    for my $key (keys %{$self->{arp_cache}}) {
	$rtn = $rtn . int_to_ip($key) . " -> ";
	$rtn = $rtn . $self->{arp_cache}->{$key} . "\n";
    }
    return $rtn;
}

sub send_tap {
    my ($self) = @_;
    my $eth_raw = shift(@{$self->{eth}->{tap_down}});
    if (!defined $eth_raw) {
	return;
    }
    
    syswrite($self->{fh}, $eth_raw);
}

sub stdout_p {
    my ($self) = @_;
    while (@{$self->{stdout}} != 0) {
	print(shift(@{$self->{stdout}}));
    }
    print("shell: ");
}


sub stdin_p {
    my ($self) = @_;
    
    my $command = shift(@{$self->{stdin}});
    if (!defined $command) {
	return;
    }
    chop($command);

    my $out = "";
    if($command eq "h") {
	$out = "h\thelp\nl\tlist size of fifo queues\np ip\tping ip address\nq\tquit\n";
    } elsif ($command eq "a") {
	$out = "ARP Cache:\n" . $self->dump_arp();
    } elsif ($command eq "q") {
	exit(0);
    } else {
	$out = "ERROR type h<CR> for help\n";
    }
    push(@{$self->{stdout}}, $out);
    push(@{$self->{task}}, sub {$self->stdout_p});
}
