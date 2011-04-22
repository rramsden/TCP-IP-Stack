package NetStack::ICMP;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::ICMP;
use Packet::ICMP qw/ :types /;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	icmp_up   => [],
	icmp_down => [],
	ip_down   => [],
	ip_p      => sub {},
	stdout    => [],
	stdout_p    => sub {},
	task      => [],
	@args
    };
    
    return bless($self, $class);
}

sub process_up {
    my ($self) = @_;
  
    my $tuple = shift(@{$self->{icmp_up}});
    
    if (!defined $tuple) {
	return; # Nothing to process
    }
    my ($icmp_raw, $src_ip) = @{$tuple};
    
    my $icmp_obj = Packet::ICMP->new();
    $icmp_obj->decode($icmp_raw);
    if ($icmp_obj->{type} == ICMP_ECHO_REPLY) { # Ping reply
	#for now just put on the queue to right to std out
	my $out="Ping replied to\n";
	push(@{$self->{stdout}},$out);
	push(@{$self->{task}},$self->{stdout_p});
	
    } elsif ($icmp_obj->{type} == ICMP_ECHO) { # Ping request
	$icmp_obj->{type} = ICMP_ECHO_REPLY;
	$icmp_obj->{autogen_chksum} = 1; # Important!
	push(@{$self->{icmp_down}}, [$icmp_obj, $src_ip]);
	push(@{$self->{task}}, sub {$self->process_down()});
    
    } elsif ($icmp_obj->{type} == ICMP_DEST_UNREACH) { #recieved a destination unreachable packet...
	my $out="Destination Unreachable\n";
	push(@{$self->{stdout}},$out);
	push(@{$self->{task}}, $self->{stdout_p});

    } elsif ($icmp_obj->{type} == ICMP_SRC_QUENCH) { #recieved a source quench packet...

    } elsif ($icmp_obj->{type} == ICMP_REDIRECT) { #recieved a redirect packet...

    } elsif ($icmp_obj->{type} == 9) { #9 is not in the PACKET module but is Router Advertisement

    } elsif ($icmp_obj->{type} == 10) { #10 is also not in the PACKET module means Router Selection

    } elsif ($icmp_obj->{type} == ICMP_TIME_EXCEED) { #time was exceeded for a response look at the code

    } elsif ($icmp_obj->{type} == ICMP_PARAM_PROBLEM) { #there was a problem with the paramaters also look at the code

    } elsif ($icmp_obj->{type} == ICMP_TIMESTAMP) { #timestamp request packet

    } elsif ($icmp_obj->{type} == ICMP_TIMESTAMP_REPLY) { #timestamp reply packet

    } elsif ($icmp_obj->{type} == ICMP_INFO_REQUEST) { #a request for information was recieved

    } elsif ($icmp_obj->{type} == ICMP_INFO_REPLY) { # a request for information was sent out

    } elsif ($icmp_obj->{type} == 17) { #no code in module, means ADDRESS Mask Request

    } elsif ($icmp_obj->{type} == 18) { #no code in module, means Address Mask Reply

    } elsif ($icmp_obj->{type} == 30) { #traceroute packet no code in module.
    }

}

sub process_down {
    my ($self) = @_;
 
    my $tuple = shift(@{$self->{icmp_down}});

    if (!defined $tuple) {
	return; # Nothing to process
    }
    my ($icmp_obj, $dest_ip) = @{$tuple};
  
    my $ip_obj = Packet::IP->new();
    $ip_obj->{dest_ip} = $dest_ip;
    $ip_obj->{proto} = 1; #ICMP
    $ip_obj->{data} = $icmp_obj->encode();
    
    push(@{$self->{ip_down}}, $ip_obj);
    push(@{$self->{task}}, $self->{ip_p});
}

1;
