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
    if ($icmp_obj->{type} == ICMP_ECHO_REPLY) { # Ping request
	
    } elsif ($icmp_obj->{type} == ICMP_ECHO) { # Ping request
	$icmp_obj->{type} = ICMP_ECHO_REPLY;
	$icmp_obj->{autogen_chksum} = 1; # Important!
	push(@{$self->{icmp_down}}, [$icmp_obj, $src_ip]);
	push(@{$self->{task}}, sub {$self->process_down()});
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
