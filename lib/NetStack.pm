package NetStack;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib ".";

use IO::Select;
use Packet::Definitions;
use Packet::Ethernet;
use Packet::ARP;
use Packet::IP;
use Packet::ICMP qw/ :types /;
use Packet::Lookup qw/ :mac :ip /;
#use Net::Pcap;
use TunTap;
#use Time::HiRes qw/gettimeofday/;

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
	my_mac => "ff:ff:ff:ff:ff:ff",
	my_ip  => "192.168.56.1",
	device => "tap0",
	netmask => "255.255.255.0",
	default => "192.168.56.1",
	fh => "",
	ARP_cahce => {},
	# Will overwrite any of the default values with the user's
	@args
    };
    
    return bless($self, $class);
}


sub run {
    my ($self) = @_;
    my $err;


    $self->{'fh'} = TunTap->attach(
	name => $self->{'device'}
	);
    
    my $sel = new IO::Select();
    $sel->add($self->{'fh'});
    my $count = 0;
    while ( 1 ) {
	if ( $sel->can_read() ) {
	    $count++;
	    
	    my $raw_pkt;
	    my $ret = sysread($self->{'fh'}, $raw_pkt, 4096);
	    
	    my $eth = Packet::Ethernet->new();
	    my $pre;
	    my $raw_eth;
	    # Remove 4 bytes of preamble
	    ($pre, $raw_eth) = unpack('H8 a*', $raw_pkt);
	    #printf("%b\n", $pre);
	    #print $eth->hexdump($raw_pkt), "\n";

	    $self->{pre} = $pre;
	    $self->recv_eth($raw_eth);
	}
    }
    
}

sub dump_arp {
    for my $key (keys %{$self->{ARP_cache}}) {
	print  int_to_ip($key), " -> ";
	print $self->{ARP_cache}->{$key} ,"\n";
	print $self->{default}, "\n";
    }
}

sub send_tap {
    my ($self, $raw_eth) = @_;
    my $raw_pkt = pack('H8 a*', $self->{pre}, $raw_eth);
    syswrite($self->{fh}, $raw_pkt);
    
}

# Process Ethernet packet
sub recv_eth {
    my ($self, $eth_raw) = @_;
    
    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->decode($eth_raw);
    
    # Switch on type
    if ($eth_obj->{type} == $ETH_TYPE_ARP) {
	$self->recv_arp($eth_obj->{data});
    } elsif ($eth_obj->{type} == $ETH_TYPE_IP) {
	$self->recv_ip($eth_obj->{data});
    }
    
}

# Send Ethernet packet
# TODO - change $dest_eth to $dest_ip and do a lookup
#         ie. check ARP cache
sub send_eth {
    my ($self, $eth_obj, $dest_ip) = @_;
    
    $eth_obj->{src_mac} = $self->{my_mac};
    
    # Always use 'default'
    my $dest_eth = $self->{ARP_cache}->{ip_to_int($self->{default})};
    if (!defined($dest_eth)) {
	printf("Need to make an ARP request %s\n", int_to_ip($dest_ip));
	return;
    }
    
    $eth_obj->{dest_mac} = $dest_eth;
    
    #my $dest_mac = lookup_ip($dest_ip);
    #if (defined($dest_mac)) {
    #$eth_obj->dest_mac($dest_mac);
    #} else {
    # Put eth_obj + dest_ip in list
    # Send ARP request
    #}
    
    my $eth_raw = $eth_obj->encode();
    $self->send_tap($eth_raw);
}

sub recv_arp {
    my ($self, $arp_raw) = @_;
    
    my $arp_obj = Packet::ARP->new();
    $arp_obj->decode($arp_raw);
    # Update ARP cahce
    $self->{ARP_cache}->{$arp_obj->{sender_ip}} = $arp_obj->{sender_eth};
    
    if ($arp_obj->{target_ip} eq $self->{my_ip}) {
	print "ARP: Not for me\n";
	return;
    }

    if ($arp_obj->{opcode} == 1) {
	print "ARP request\n";
	my $arp_reply = Packet::ARP->new();
	
	# So we don't have to copy all the members over
	$arp_reply->decode($arp_raw);
	# Change to a reply
	$arp_reply->{opcode} = 2;
	$arp_reply->{sender_eth} = $self->{my_mac};
	$arp_reply->{sender_ip} = $self->{my_ip};
	$arp_reply->{target_eth} = $arp_obj->{sender_eth};
	$arp_reply->{target_ip} = $arp_obj->{sender_ip};

	$self->send_arp($arp_reply);
    } elsif ($arp_obj->{opcode} == 2) {
	print "reply\n";
	# Cache updated from above
	# TODO: check pending ethernet packets & send
    } else {
	print "ARP: garbage\n";
    }
}

sub send_arp {
    my ($self, $arp_obj) = @_;
    
    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->{data} = $arp_obj->encode();
    $eth_obj->{type} = $ETH_TYPE_ARP;
    
    $self->send_eth($eth_obj, $arp_obj->{target_ip});
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
    
    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->{data} = $ip_obj->encode();
    $eth_obj->{type} = $ETH_TYPE_IP;

    $self->send_eth($eth_obj, $ip_obj->{dest_ip});
}

sub recv_ip6 {


}

sub send_ip6 {


}


sub recv_icmp {
    my ($self, $icmp_raw, $src_ip) = @_;
    
    my $icmp_obj = Packet::ICMP->new();
    $icmp_obj->decode($icmp_raw);
    if ($icmp_obj->{type} == ICMP_ECHO_REPLY) { # Ping request
	
    } elsif ($icmp_obj->{type} == ICMP_ECHO) { # Ping request
	print "Ping request\n";
	$icmp_obj->{type} = ICMP_ECHO_REPLY;
	$icmp_obj->{autogen_chksum} = 1;
	$self->send_icmp($icmp_obj, $src_ip);
    }
    
    
}

sub send_icmp {
    my ($self, $icmp_obj, $dest_ip) = @_;
    
    my $ip_obj = Packet::IP->new();
    $ip_obj->{dest_ip} = $dest_ip;
    $ip_obj->{proto} = 1;
    $ip_obj->{data} = $icmp_obj->encode();

    $self->send_ip($ip_obj);

}
