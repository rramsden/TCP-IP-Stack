package NetStack::UDP;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::UDP;
#use Packet::ICMP qw/ :types /;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	udp_up   => [],
	udp_down => [],
	ip_down   => [],
	ip_p      => sub {},
	stdout    => [],
	stdout    => sub {},
	task      => [],
	@args
    };
    
    return bless($self, $class);
}

sub process_up {
    my ($self) = @_;
  
    my $tuple = shift(@{$self->{udp_up}});
    
    if (!defined $tuple) {
	return; # Nothing to process
    }
    my ($udp_raw, $src_ip) = @{$tuple};
    
    my $udp_obj = Packet::UDP->new();
    $udp_obj->decode($udp_raw);
    
    
    push(@{$self->{stdout}}, $udp_obj->{data});
    push(@{$self->{task}},  $self->{stdout_p});
    
}

sub process_down {
    my ($self) = @_;
 
    my $tuple = shift(@{$self->{udp_down}});

    if (!defined $tuple) {
	return; # Nothing to process
    }
    my ($udp_obj, $dest_ip) = @{$tuple};
  
    my $ip_obj = Packet::IP->new();
    $ip_obj->{dest_ip} = $dest_ip;
    $ip_obj->{proto} = 17; #UDP
    $ip_obj->{data} = $udp_obj->encode();
    
    push(@{$self->{ip_down}}, $ip_obj);
    push(@{$self->{task}}, $self->{ip_p});
}

1;
