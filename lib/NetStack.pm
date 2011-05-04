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
	icmp_out => [],
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
	my_ip => $self->{my_ip},
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
	my_ip => $self->{my_ip},
	tcp_up => $self->{ip}->{tcp_up},
	ip_down => $self->{ip}->{ip_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	#services are configured in stack.pl
	);

    $self->{udp} = NetStack::UDP->new(
	my_ip => $self->{my_ip},
	udp_up => $self->{ip}->{udp_up},
	ip_down => $self->{ip}->{ip_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()}
	#services are configured in stack.pl
	);
    
    $self->{icmp} = NetStack::ICMP->new(
	icmp_up => $self->{ip}->{icmp_up},
	ip_down => $self->{ip}->{ip_down},
	task => $self->{task},
	stdout => $self->{stdout},
	stdout_p => sub {$self->stdout_p()},
	out_arr => $self->{icmp_out}
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

    my $eth_timer = AnyEvent->timer(
	after => 1,
	interval => .1,
	cb => sub {
	    $self->{eth}->process_wait();
	}
	);

    my $arp_timer = AnyEvent->timer(
	after => 1,
	interval => .5,
	cb => sub {
	    $self->{arp}->timeout_cache();
	}
	);
	
    
    $y_event->recv;

    return;	
}

sub dump_arp {
    my ($self) = @_;
    my $rtn = "";
    for my $ip (keys %{$self->{arp_cache}}) {
	my ($eth, $time) = @{$self->{arp_cache}->{$ip}};
	$rtn = $rtn . int_to_ip($ip) . " -> ";
	$rtn = $rtn . $eth . " ($time)\n";
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
    print("\n");
    while (@{$self->{stdout}} != 0) {
	print(shift(@{$self->{stdout}}));
    }
    print("shell: ");
}

sub udp_send {

    my ($self, $targetIP, $targetPort, $data) = @_;
    
    my $udp_obj = Packet::UDP->new();
    $udp_obj->{src_port} = 7; 
    $udp_obj->{dest_port} = $targetPort;
    $udp_obj->{data} = $data;
    push(@{$self->{udp}->{udp_down}}, [$udp_obj, $targetIP]);
    push(@{$self->{task}}, sub {$self->{udp}->process_down();});    

}

sub ping{
    my ($self, $ip, $sequence, @rest) = @_;
    my $pingPack = Packet::ICMP->new();
    my $pingIdentifier = 6387;

    $pingPack->{type}=8;
    $pingPack->{autogen_cksum}=1;
    $pingPack->{data}=pack('nn',$pingIdentifier, $sequence);
    my $ipToPing=$ip;
    my $tuple = [$pingPack, $ipToPing];
    push(@{$self->{icmp}->{icmp_down}}, $tuple);
    push(@{$self->{task}}, sub {$self->{icmp}->process_down()});
    push(@{$self->{task}}, sub{$self->pingInPack($sequence);});
}

sub pingInPack{
    my ($self, $sequence, @rest) = @_;
    #dont flood network, wait for a reply before requesting again
    #reply could be redirect, unreachable, reply, or time out\
    my $arraySize=@{$self->{icmp_out}};
    if ($arraySize==0){
	push(@{$self->{task}}, sub{$self->pingInPack($sequence);});
	return;
    }else{
	my $tuple=shift(@{$self->{icmp_out}});
	my ($packRec, $src_ip)=@{$tuple};
	my $out;
	my $reping=1;

	if ($packRec->{type}==ICMP_ECHO_REPLY){
	    $out="Ping replied to!\n";
	}elsif ($packRec->{type}==ICMP_DEST_UNREACH){
	    $out="Destination unreachable, ping stopped";
	    $reping=0;
	}elsif ($packRec->{type}==ICMP_REDIRECT){
	    $out="Recieved redirect, next packet to new destination";
	    $src_ip=unpack('N', $packRec->{data}); #N is 32 bit network order
	    #and ip addresses are 32 bit integers. This functionality
	    #is untested.
	}elsif ($packRec->{type}==ICMP_TIME_EXCEED){
	    $out="Time out reached";
        }else{
	    $reping=0;
	}
	push(@{$self->{stdout}}, $out);
	push(@{$self->{task}}, sub{$self->stdout_p});
	my $command="$src_ip";
	$sequence+=1;
	if (($reping==1) && ($sequence<11)){
	    push(@{$self->{task}}, sub{$self->ping($command, $sequence);});
	}
    }
    #while (!defined $packRec){
    # print ("Waiting");
    #    $packRec=shift(@{$self->{icmp_out}});
    #}
    
    #guarenteed to have a packet now
    #so check identifier
    #my ($packRecID, $sequencenum)=unpack('nn',$packRec->{data});
    #while (!$packRecID==$pingIdentifier){
    #   print $packRecID;
    #  print $sequencenum;
    # push(@{$self->{icmp_out}}, $packRec);
    #$packRec=shift(@{$self->{icmp_out}}); 
    #($packRecID, $sequencenum)=unpack('nn',$packRec->{data});
    #}
}

sub stdin_p {
    my ($self) = @_;
    
    my $input = shift(@{$self->{stdin}});
    my @command;
    if (!defined $input) {
	return;
    }
    chop($input);
    
    @command = split(/ /, $input);
    #After the split, assuming correct input 
    #$command[0] is the command
    #$command[1] is the target IP address
    #$command[2] is the target port number 
    #$command[3] is the message
    #Anything else is garbage and should be ignored

    my $out = "";
    if($command[0] eq "h") {
	$out = "h - Help\n" .
               "a - Dump ARP cache\n" .
	       "c - Clear ARP cache\n" .
	       "e <ip> <port> <message> - UDP message to echoserver at <ip> on <port>\n" .
	       "q - Quit\n";
    } elsif ($command[0] eq "a") {
	$out = "ARP Cache:\n" . $self->dump_arp();
    } elsif ($command[0] eq "c") {
	$out = "ARP cache cleared!\n";
	%{$self->{arp_cache}} = ();
    }elsif ($command[0] eq "e"){
	$out = "Sending Echo Packet...\n";
	$self->udp_send($command[1], $command[2], $command[3]);
    } elsif ($command[0] eq "q") {
	exit(0);
    }elsif ($command[0] eq "p") {
	push(@{$self->{task}}, sub{$self->ping($command[1], 1)});
    } else {
	$out = "ERROR type h<CR> for help\n";
    }
    push(@{$self->{stdout}}, $out);
    push(@{$self->{task}}, sub {$self->stdout_p});
}
