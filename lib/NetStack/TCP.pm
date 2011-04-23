package NetStack::TCP;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::TCP;
use Packet::TCP qw/ :flags :states /;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	my_ip     => "133.7.0.1",
	tcp_up    => [],
	tcp_down  => [],
	ip_down   => [],
	ip_p      => sub {},
	stdout    => [],
	stdout_p  => sub {},
	sockets   => {},
	task      => [],
    connections => {},
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
    my $src_port = $tcp_obj->{src_port};
    my $dest_port = $tcp_obj->{dest_port};

	# fetch session information
	my ($sequence, $state) = (0,0);
	if ( $self->{connections}{$tcp_obj->{src_port}} ) {
    	($sequence, $state) = @{$self->{connections}{$tcp_obj->{src_port}}};
	}

    # Diagram for TCP state machine http://tools.ietf.org/html/rfc793#page-23
	# basic SYN/ACK shinnenigans below 

    # SYN RECVIEVED
    if ($tcp_obj->{flags} == SYN) {
      if (!$state) {
        $tcp_obj = Packet::TCP->new(
          src_port => $dest_port,
          dest_port => $src_port,
          flags => (SYN|ACK),
          acknum => $tcp_obj->{seqnum} + 1 # increase by one to indicated next sequence in stream
        );
        
		# create connection, store initial state and ISN (intial sequence number)
        $self->{connections}{$src_port} = [$tcp_obj->{seqnum}, SYN_RECEIVED];
      }
    }
    # CONNECTION ESTABLISHED
    elsif ($tcp_obj->{flags} == ACK) {
      $self->{connections}{$tcp_obj->{src_port}} = [$sequence, ESTABLISHED];
      print "client " . $src_ip . " connected on port " . $tcp_obj->{dest_port} . "\n";
    }
    # RECEIVING TCP STREAM
    elsif ($tcp_obj->{flags} == (PSH|ACK)) {
      # acknowledge data
      $tcp_obj = Packet::TCP->new(
        src_port => $tcp_obj->{dest_port},
        dest_port => $tcp_obj->{src_port},
        flags => ACK,
        seqnum => $sequence + 1,
        acknum => $tcp_obj->{seqnum} + 1
      );
     
      $self->{connections}{$tcp_obj->{src_port}} = [$sequence + 1, ESTABLISHED]; 
	}
	# CLOSE WAIT
	elsif ($tcp_obj->{flags} == (FIN|ACK)) {

      # acknowledge request for connection close
      $tcp_obj = Packet::TCP->new(
        src_port => $tcp_obj->{dest_port},
        dest_port => $tcp_obj->{src_port},
        flags => ACK,
        seqnum => $sequence + 1,
        acknum => $tcp_obj->{seqnum} + 1
      );

      $self->{connections}{$tcp_obj->{src_port}} = [$sequence + 1, CLOSE_WAIT]; 
      
      print "closing connection " . $src_ip . " on port " . $tcp_obj->{dest_port} . "\n";
	}
    
    # push out tcp packet
    push(@{$self->{tcp_down}}, [$tcp_obj, $src_ip]);
    push(@{$self->{task}}, sub {$self->process_down()});
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
  $ip_obj->{data} = $tcp_obj->encode($self->{my_ip}, $dest_ip);
    
  push(@{$self->{ip_down}}, $ip_obj);
  push(@{$self->{task}}, $self->{ip_p});
}

1;
