package NetStack::Ethernet;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::Ethernet;
use Packet::Definitions;
use Packet::Lookup qw/ :mac :ip /;

my $ETH_TYPE_ARP = &Packet::Definitions::ETHERTYPE_ARP;
my $ETH_TYPE_IP = &Packet::Definitions::ETHERTYPE_IP;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	eth_up    => [],
	eth_down  => [],
	arp_up    => [],
	arp_p     => sub {},
	ip_up     => [],
	ip_p      => sub {},
	tap_down  => [],
	tap_p     => sub {},
	stdout    => [],
	stdout    => sub {},
	arp_cache => {},
	task      => [],
	my_mac    => "11:22:33:44:55:66",
	default   => "192.168.1.1",
	@args
    };
    return bless($self, $class);
}

# Process Ethernet packet
sub process_up {
    my ($self) = @_;
    my $eth_raw = shift(@{$self->{eth_up}});
    if (!defined $eth_raw) {
	return;
    }

    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->decode($eth_raw);
    
    # Switch on type
    if ($eth_obj->{type} == $ETH_TYPE_ARP) {
	push(@{$self->{arp_up}}, $eth_obj->{data});
	push(@{$self->{task}}, $self->{arp_p});
    } elsif ($eth_obj->{type} == $ETH_TYPE_IP) {
	push(@{$self->{ip_up}}, $eth_obj->{data});
	push(@{$self->{task}}, $self->{ip_p});
    } else {
	print $eth_obj->{type}, "\n";
    }
}

# Send Ethernet packet
# TODO - change $dest_eth to $dest_ip and do a lookup
#         ie. check ARP cache
sub process_down {
    my ($self) = @_;

    my $tuple = shift(@{$self->{eth_down}});
    
    if (!defined $tuple) {
	return;
    }
    my ($eth_obj, $dest_ip) = @{$tuple};

    $eth_obj->{src_mac} = $self->{my_mac};
    # Always use 'default'
    my $dest_eth = $self->{arp_cache}->{ip_to_int($self->{default})};
    if (!defined($dest_eth)) {
	printf("Need to make an ARP request %s\n", $self->{default});
	return;
    }

    $eth_obj->{dest_mac} = $dest_eth;
    #print $eth_obj->{dest_mac}, "\n";

    #my $dest_mac = lookup_ip($dest_ip);
    #if (defined($dest_mac)) {
    #$eth_obj->dest_mac($dest_mac);
    #} else {
    # Put eth_obj + dest_ip in list
    # Send ARP request
    #}
    
    my $eth_raw = $eth_obj->encode();
    push(@{$self->{tap_down}}, $eth_raw);
    push(@{$self->{task}}, $self->{tap_p});
}

1;
