package NetStack;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib ".";

use Packet::Definitions;
use Packet::Ethernet;
use Packet::ARP;
use Net::Pcap;
use Time::HiRes qw/gettimeofday/;

my $ETH_TYPE_ARP = &Packet::Definitions::ETHERTYPE_ARP;
my $ETH_TYPE_IP = &Packet::Definitions::ETHERTYPE_IP;

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
	my_mac => "ab:cd:ef:ab:cd:ef",
	my_ip  => "192.168.0.198",
	device => "",
	netmask => "",
	gateway => "000.000.000",
	in => "",
	out => "",
	# Will overwrite any of the default values with the user's
	@args
    };
    
    return bless($self, $class);
}


sub run {
    my ($self) = @_;
    my $err;
    # TODO: open device instead of file
    $self->{in} = Net::Pcap::open_offline("task5.cap", \$err);
    $self->{out} = Net::Pcap::dump_open($self->{in}, 'peter.cap');
    
    # Main loop
    #  Will need to modify this to use our own loop
    #  and use Net::Pcap::next(...) 
    Net::Pcap::loop($self->{in}, -1, \&callback, $self);
    
    
    Net::Pcap::dump_close($self->{out});
    Net::Pcap::close($self->{in});
}

sub callback {
    my ($self, $hdr, $pkt) = @_;
    #send up the stack
    $self->recv_eth($pkt);
}

# Process Ethernet packet
sub recv_eth {
    my ($self, $eth_raw) = @_;
    
    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->decode($eth_raw);
    
    # Switch on type
    if ($eth_obj->{type} == $ETH_TYPE_ARP) {
	$self->recv_arp($eth_obj->{data});
    }
    
}

# Send Ethernet packet
# TODO - change $dest_eth to $dest_ip and do a lookup
#         ie. check ARP cache
sub send_eth {
    my ($self, $eth_obj, $dest_eth) = @_;
    
    $eth_obj->{src_mac} = $self->{my_mac};
    
    $eth_obj->dest_mac($dest_eth);
    
    #my $dest_mac = lookup_ip($dest_ip);
    #if (defined($dest_mac)) {
    #$eth_obj->dest_mac($dest_mac);
    #} else {
    # Put eth_obj + dest_ip in list
    # Send ARP request
    #}
    
    my $eth_raw = $eth_obj->encode();
    # Create ethernet header
    # ONLY for dumping to file
    my %hdr;
    %hdr->{'len'} = 512;
    %hdr->{'caplen'} = length $eth_raw;
    (%hdr->{'tv_sec'}, %hdr->{'tv_usec'}) = gettimeofday();
    
    
    Net::Pcap::dump($self->{out}, \%hdr, $eth_obj->encode());    
}

sub recv_arp {
    my ($self, $arp_raw) = @_;
    
    my $arp_obj = Packet::ARP->new();
    $arp_obj->decode($arp_raw);
    if ($arp_obj->{target_ip} == $self->{my_ip}) {
	print "ARP: Not for me\n";
    }
    if ($arp_obj->{opcode} == 1) {
	print "request\n";
	my $arp_reply = Packet::ARP->new();
	
	# So we don't have to copy all the members over
	$arp_reply->decode($arp_raw);
	# Change to a reply
	$arp_reply->{opcode} = 2;
	$arp_reply->{sender_eth} = $self->{my_mac};
	$arp_reply->{sender_ip} = $self->{my_ip};
	$arp_reply->{target_eth} = $arp_obj->sender_eth();
	$arp_reply->{target_ip} = $arp_obj->sender_ip();
	$self->send_arp($arp_reply);
    } elsif ($arp_obj->{opcode} == 2) {
	print "reply\n";
	# Add to cache
	# check pending ethernet packets & send
    } else {
	print "ARP: garbage\n";
    }
}

sub send_arp {
    my ($self, $arp_obj) = @_;

    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->{data} = $arp_obj->encode();
    $eth_obj->{type} = $ETH_TYPE_ARP;
    #                         change to IP
    $self->send_eth($eth_obj, $arp_obj->{target_eth});
}

sub recv_ip {
    my ($self, $ip_raw) = @_;
    
    my $ip_obj = Packet::IP->new();
    $ip_obj->decode($ip_raw);
    
    if ($ip_obj->{proto} == 1) {#ICMP
	$self->recv_icmp($ip_obj->{data}, $ip_obj->{src_ip});
	
    } elsif ($ip_obj->{proto} == 2) {#IGMP
	
    } #...

}

sub send_ip {
    my ($self, $ip_obj) = @_;
    $ip_obj->{src_ip} = $self->{my_ip};
    my $eth_obj = Packet::IP->new();
    $eth_obj->{data} = $ip_obj->encode();
    $eth_obj->{type} = $ETH_TYPE_IP;
    
    $self->eth_send($eth_obj, $ip_obj->{dest_ip});
}

sub recv_ip6 {


}

sub send_ip6 {


}


sub recv_icmp {
    my ($self, $icmp_raw, $src_ip) = @_;
    
    
    
}

sub send_icmp {
    my ($self, $icmp_obj, $dest_ip) = @_;
    
    my $ip_obj = Packet::IP->new();
    $ip_obj->{dest_ip} = $dest_ip;
    $ip_obj->{data} = $icmp_obj->encode();
    $self->send_ip($ip_obj);
}
