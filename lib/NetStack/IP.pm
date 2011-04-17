package NetStack::IP;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::IP;

my $ETH_TYPE_IP = &Packet::Definitions::ETHERTYPE_IP;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	my_ip    => "192.168.56.1",
	ip_up    => [],
	ip_down  => [],
	eth_down => [],
	eth_p    => sub {},
	icmp_up  => [],
	icmp_p   => sub {},
	# Need to put other FIFOs here...
	task     => [],
	@args
    };
    
    return bless($self, $class);
}


sub process_up {
    my ($self) = @_;

    my $ip_raw = shift(@{$self->{ip_up}});
    if (!defined $ip_raw) {
	return;
    }

    my $ip_obj = Packet::IP->new();
    $ip_obj->decode($ip_raw);

    if ($ip_obj->{proto} == 1) {#ICMP
	push(@{$self->{icmp_up}}, [$ip_obj->{data}, $ip_obj->{src_ip}]);
	push(@{$self->{task}}, $self->{icmp_p});
    } elsif ($ip_obj->{proto} == 2) {#IGMP
	
    } #...

}

sub process_down {
    my ($self) = @_;

    my $ip_obj = shift(@{$self->{ip_down}});
    if (!defined $ip_obj) {
	return; # Nothing to process
    }

    $ip_obj->{src_ip} = $self->{my_ip};
    
    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->{data} = $ip_obj->encode();
    $eth_obj->{type} = $ETH_TYPE_IP;

    push(@{$self->{eth_down}}, [$eth_obj, $ip_obj->{dest_ip}]);
    push(@{$self->{task}}, $self->{eth_p});
}

1;
