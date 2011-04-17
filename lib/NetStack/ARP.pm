package NetStack::ARP;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::ARP;

my $ETH_TYPE_ARP = &Packet::Definitions::ETHERTYPE_ARP;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	arp_up    => [],
	arp_down  => [],
	eth_down  => [],
	eth_p     => sub {},
	arp_cache => {},
	task =>   => [],
	my_mac    => "11:22:33:44:55:66",
	my_ip => "192.168.1.1",
	@args
    };
    return bless($self, $class);
}


sub process_up {
    my ($self) = @_;
    
    my $arp_raw = shift(@{$self->{arp_up}});
    if (!defined $arp_raw) {
	return;
    }

    my $arp_obj = Packet::ARP->new();
    $arp_obj->decode($arp_raw);
    # Update ARP cahce
    $self->{arp_cache}->{$arp_obj->{sender_ip}} = $arp_obj->{sender_eth};
    
    if ($arp_obj->{target_ip} eq $self->{my_ip}) {
	#print "ARP: Not for me\n";
	return;
    }

    if ($arp_obj->{opcode} == 1) {
	my $arp_reply = Packet::ARP->new();
	
	# So we don't have to copy all the members over
	$arp_reply->decode($arp_raw);
	# Change to a reply
	$arp_reply->{opcode} = 2;
	$arp_reply->{sender_eth} = $self->{my_mac};
	$arp_reply->{sender_ip} = $self->{my_ip};
	$arp_reply->{target_eth} = $arp_obj->{sender_eth};
	$arp_reply->{target_ip} = $arp_obj->{sender_ip};

	push(@{$self->{arp_down}}, $arp_reply);
	push(@{$self->{task}}, sub {$self->process_down()});
    } elsif ($arp_obj->{opcode} == 2) {
	# Cache updated from above
	# TODO: check pending ethernet packets & send
    } else {
	#print "ARP: garbage\n";
    }
}

sub process_down {
    my ($self) = @_;
    
    my $arp_obj = shift(@{$self->{arp_down}});
    if (!defined $arp_obj) {
	return;
    }
    my $eth_obj = Packet::Ethernet->new();
    $eth_obj->{data} = $arp_obj->encode();
    $eth_obj->{type} = $ETH_TYPE_ARP;
    push(@{$self->{eth_down}}, [$eth_obj, $arp_obj->{target_ip}]);
    push(@{$self->{task}}, $self->{eth_p});
}

1;
