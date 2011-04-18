package NetStack::TCP;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::TCP;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	tcp_up   => [],
	tcp_down => [],
	ip_down   => [],
	ip_p      => sub {},
	stdout    => [],
	stdout    => sub {},
	sockets => {},
	task      => [],
	@args
    };
    
    return bless($self, $class);
}

sub process_up {
    my ($self) = @_;
    
    my $tuple = shift(@{$self->{tcp_up}});
    
	if (!defined $tuple) {
		return; # Nothing to process
    }
    my ($tcp_raw, $src_ip) = @{$tuple};
    
    my $tcp_obj = Packet::TCP->new();
    $tcp_obj->decode($tcp_raw);
    
    # Control Bits:  6 bits (from left to right):
    #
    #  URG:  Urgent Pointer field significant 1 . . . . . 32
    #  ACK:  Acknowledgment field significant . 1 . . . . 16
    #  PSH:  Push Function                    . . 1 . . .  8
    #  RST:  Reset the connection             . . . 1 . .  4
    #  SYN:  Synchronize sequence numbers     . . . . 1 .  2
    #  FIN:  No more data from sender	      . . . . . 1  1
    #

    # Diagram for TCP state machine http://tools.ietf.org/html/rfc793#page-23
	# basic SYN/ACK shinnenigans below 
 
    # SYN RECVIEVED
    if ($tcp_obj->{syn} == 1 && $tcp_obj->{ack} == 0) {
		# reply to client that we acknowledge the request to establish connection
		my $rcv_syn = Packet::TCP->new(
			src_port => $tcp_obj->{dest_port},
			dest_port => $tcp_obj->{src_port},
			syn => 1,
			ack => 1	
		);
		my $raw_tcp = $rcv_syn->encode();
	
		print "going to send something out on the wire\n";	
		push(@{$self->{tcp_down}}, [$rcv_syn, $src_ip]);
		push(@{$self->{task}}, sub {$self->process_down()});
    }
	# SYN/ACK RECEIVED
	elsif ($tcp_obj->{syn} == 1 && $tcp_obj->{ack} == 1) {
	}
}


sub process_down {
	my ($self) = @_;

	my $tuple = shift(@{$self->{tcp_down}});

	if (!defined $tuple) {
		return; # Nothing to process
	}

    my ($tcp_obj, $dest_ip) = @{$tuple};
  
    my $ip_obj = Packet::IP->new();
    $ip_obj->{dest_ip} = $dest_ip;
    $ip_obj->{proto} = 6; #TCP
    $ip_obj->{data} = $tcp_obj->encode();
    
    push(@{$self->{ip_down}}, $ip_obj);
    push(@{$self->{task}}, $self->{ip_p});
}

1;
