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
	connections => {},
	task      => [],
	@args
    };
    
    return bless($self, $class);
}

sub process_up {
    my ($self) = @_;
    
    my $tcp_raw = shift(@{$self->{tcp_up}});
    
    if (!defined $tcp_raw) {
	return; # Nothing to process
    }
    
    my $tcp_obj = Packet::TCP->new();
    
    # just dump packet for now
    print $tcp_obj->hexdump($tcp_raw);
    
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
}


sub process_down {
   print "SHOULDNT GET CALLED\n";
}

1;
