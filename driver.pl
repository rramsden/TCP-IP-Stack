#!/usr/bin/perl -w

# For csci 460 
# routines for Ethernet and Arp encoding to be
# used in conjunction with NetPacket (installed in otter)
# Files can be found in /home/faculty/pwalsh/csci460/Stack on otter
# Peter 

use strict;

use lib "lib";

use Exporter;
#use NetPacket::Ethernet qw/ :types /;
#use NetPacket::ARP;
use Packet::Definitions;
use Packet::Ethernet;
use Packet::ARP;
use Net::Pcap;

my $ETH_TYPE_ARP = &Packet::Definitions::ETHERTYPE_ARP;

# open i/o traces
my $err;
my $in_trace=Net::Pcap::open_offline("task5.cap", \$err);
my $out_trace=Net::Pcap::dump_open($in_trace, 'peter.cap');
#my $mac = "000475f486fb";

# Process packets
Net::Pcap::loop($in_trace, -1, \&process_packet, '');


# read first frame from task5.cap
#$raw_eth_pkt=Net::Pcap::next($in_trace, \%hdr);

# Write Ethernet frame to peter.cap
#Net::Pcap::dump($out_trace, \%hdr, $xraw_eth_pkt);

Net::Pcap::dump_close($out_trace);
# For correctness, compare the first frame from task5.cap with the only frame in peter.cap 
# using wireshark or hexdump


sub process_packet {
    my ($user_data, $hdr, $pkt) = @_;
    
    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->decode($pkt);
    print $eth_obj->{src_mac}, "\n";

    if ($eth_obj->{type} == $ETH_TYPE_ARP) {# ARP
	my $arp_obj = Packet::ARP->new();
	$arp_obj->decode($eth_obj->{data});
	print $arp_obj->{sender_eth}, "\n";
	print "Opcode: ", $arp_obj->{opcode}, "\n";
	
	my $arp_reply = Packet::ARP->new();
	$arp_reply->{htype}     = $arp_obj->{htype};
	$arp_reply->{proto}     = $arp_obj->{proto};
	$arp_reply->{hlen}      = $arp_obj->{hlen};
	$arp_reply->{plen}      = $arp_obj->{plen};
	$arp_reply->{opcode}    = 2;
	$arp_reply->{sender_eth}= 0; # Our mac
	$arp_reply->{sender_ip} = $arp_obj->{target_ip};
	$arp_reply->{target_eth}= $arp_obj->{sender_eth};
	$arp_reply->{target_ip} = $arp_obj->{sender_ip};
	
	my $eth_reply = Packet::Ethernet->new();
	$eth_reply->{src_mac} = $eth_obj->{dest_mac};
	$eth_reply->{dest_mac} = $eth_obj->{src_mac};
	$eth_reply->{type} = $ETH_TYPE_ARP;
	$eth_reply->{data} = $arp_reply->encode();
	my $raw_reply = $eth_reply->encode();

	Net::Pcap::dump($out_trace, $hdr, $raw_reply);
    }
}
