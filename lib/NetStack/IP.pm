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
	tcp_up   => [],
    tcp_p    => sub {},
	eth_down => [],
	eth_p    => sub {},
	icmp_up  => [],
	icmp_p   => sub {},
	udp_up  => [],
	udp_p   => sub {},
	stdout    => [],
	stdout    => sub {},
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

    my $protocol = $ip_obj->{proto};

    if ($protocol == 1) {#ICMP
		push(@{$self->{icmp_up}}, [$ip_obj->{data}, $ip_obj->{src_ip}]);
		push(@{$self->{task}}, $self->{icmp_p});
    } elsif ($protocol == 2) {#IGMP
    } elsif ($protocol == 6) {#TCP
		push(@{$self->{tcp_up}}, [$ip_obj->{data}, $ip_obj->{src_ip}]);
		push(@{$self->{task}}, $self->{tcp_p}); # invoke process_up in TCP module
    } elsif ($protocol == 17) {#UDP
		push(@{$self->{udp_up}}, [$ip_obj->{data}, $ip_obj->{src_ip}]);
		push(@{$self->{task}}, $self->{udp_p}); # invoke process_up in UDP module
    }

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
