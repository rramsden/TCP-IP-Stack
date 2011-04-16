package NetStack;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib ".";

use NetStack::Ethernet;
use NetStack::ARP;
use NetStack::IP;
use NetStack::ICMP;

use AnyEvent;

use Packet::ICMP qw/ :types /;
use Packet::Lookup qw/ :mac :ip /;

use TunTap;

my $ETH_TYPE_ARP = &Packet::Definitions::ETHERTYPE_ARP;
my $ETH_TYPE_IP = &Packet::Definitions::ETHERTYPE_IP;

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
	arp_cahce => {},
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
	my_mac => $self->{my_mac},
	default => $self->{default},
	task => $self->{task},
	);

    $self->{arp} = NetStack::ARP->new(
	my_mac => $self->{my_mac},
	my_ip => $self->{my_ip},
	arp_cache => $self->{eth}->{arp_cache},
	arp_up => $self->{eth}->{arp_up},
	eth_down => $self->{eth}->{eth_down},
	task => $self->{task},
	);
    
    $self->{ip} = NetStack::IP->new(
	my_ip => $self->{my_ip},
	ip_up => $self->{eth}->{ip_up},
	eth_down => $self->{eth}->{eth_down},
	task => $self->{task},
	);
    
    $self->{icmp} = NetStack::ICMP->new(
	icmp_up => $self->{ip}->{icmp_up},
	ip_down => $self->{ip}->{ip_down},
	task => $self->{task},
	);
    
    # Link process references with anonymous subroutines
    $self->{eth}->{tap_p} = sub {$self->send_tap()};
    $self->{eth}->{arp_p} = sub {$self->{arp}->process_up()};
    $self->{eth}->{ip_p} = sub {$self->{ip}->process_up()};

    $self->{arp}->{eth_p} = sub {$self->{eth}->process_down()};

    $self->{ip}->{eth_p} = sub {$self->{eth}->process_down()};
    $self->{ip}->{icmp_p} = sub {$self->{icmp}->process_up()};

    $self->{icmp}->{ip_p} = sub {$self->{ip}->process_down()};

}

sub run {
    my ($self) = @_;
    my $err;

    $self->{'fh'} = TunTap->attach(
	name => $self->{'device'}
	);
    

    my $y_event = AnyEvent->condvar;
    my $x_event = AnyEvent->io(
	fh => $self->{fh},
	poll => "r",
	cb => sub {
	    my $pkt_raw;
	    my $ret = sysread($self->{'fh'}, $pkt_raw, 4096);
	    if (!defined($ret)) {
		return;
	    }

	    push(@{$self->{eth}->{eth_up}}, $pkt_raw);
	    push(@{$self->{task}}, sub {$self->{eth}->process_up()});
	}
	);
    
    my $z_event = AnyEvent->idle(
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
    for my $key (keys %{$self->{arp_cache}}) {
	print  int_to_ip($key), " -> ";
	print $self->{arp_cache}->{$key} ,"\n";
	print $self->{default}, "\n";
    }
}

sub send_tap {
    my ($self) = @_;
    my $eth_raw = shift(@{$self->{eth}->{tap_down}});
    if (!defined $eth_raw) {
	return;
    }
    
    syswrite($self->{fh}, $eth_raw);
}
