package NetStack::Ethernet;

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

use lib "..";

use Packet::Ethernet;
use Packet::ARP;
use Packet::Definitions;
use Packet::Lookup qw/ :mac :ip /;

my $ETH_TYPE_ARP = &Packet::Definitions::ETHERTYPE_ARP;
my $ETH_TYPE_IP = &Packet::Definitions::ETHERTYPE_IP;

sub new {
    my ($class, @args) = @_;
    
    my $self = {
	eth_up    => [],
	eth_down  => [],
	eth_wait  => [],
	arp_up    => [],
	arp_p     => sub {},
	ip_up     => [],
	ip_p      => sub {},
	tap_down  => [],
	tap_p     => sub {},
	stdout    => [],
	stdout_p  => sub {},
	arp_cache => {},
	task      => [],
	my_mac    => "11:22:33:44:55:66",
	my_ip     => "192.168.1.100",
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
    

    if ($eth_obj->{dest_mac} ne $self->{my_mac}
	&& $eth_obj->{dest_mac} ne "00:00:00:00:00:00") {
	#return; # Not for me
    }
    
    # Switch on type
    if ($eth_obj->{type} == $ETH_TYPE_ARP) {
	push(@{$self->{arp_up}}, $eth_obj->{data});
	push(@{$self->{task}}, $self->{arp_p});
    } elsif ($eth_obj->{type} == $ETH_TYPE_IP) {
	push(@{$self->{ip_up}}, $eth_obj->{data});
	push(@{$self->{task}}, $self->{ip_p});
    } else {
	#print $eth_obj->{type}, "\n";
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

    $tuple = $self->{arp_cache}->{ip_to_int($self->{default})};
    if (!defined($tuple)) {
	my $out = "Need to make an ARP request to ". $self->{default}. "\n";
	#push(@{$self->{stdout}}, $out);
	#push(@{$self->{task}}, sub {$self->stdout_p});
	
	# No ARP entry.. send ARP request
	my $arp_obj = Packet::ARP->new(
	    opcode => 1,
	    target_ip => $self->{default},
	    target_eth => "00:00:00:00:00:00",
	    sender_ip => $self->{my_ip},
	    sender_eth => $self->{my_mac}
	    );
	
	my $eth_obj2 = Packet::Ethernet->new(
	    dest_mac => "ff:ff:ff:ff:ff:ff",
	    src_mac => $self->{my_mac},
	    type => $ETH_TYPE_ARP,
	    data => $arp_obj->encode()
	    );

	push(@{$self->{tap_down}}, $eth_obj2->encode());
	push(@{$self->{task}}, $self->{tap_p});
	
	# Move Ethernet packet into eth_wait queue
	push(@{$self->{eth_wait}}, [$eth_obj, $dest_ip]);
			
    } else {
	my ($dest_eth, $time) = @{$tuple};
	$eth_obj->{dest_mac} = $dest_eth;
	
	push(@{$self->{tap_down}}, $eth_obj->encode());
	push(@{$self->{task}}, $self->{tap_p});
    }
}

# Moves ethernet objects back into the eth_down queue when they have a MAC
sub process_wait {
    my ($self) = @_;

    
    for (0..$#{$self->{eth_wait}}) {
	# Get the dest_ip
	my ($eth_obj, $dest_ip) = @{$self->{eth_wait}[$_]};
	# Check if we have a MAC for the IP
	my $tuple = $self->{arp_cache}->{ip_to_int($self->{default})};
	if (defined($tuple)) {
	    my ($dest_eth, $time) = @{$tuple};
	    
	    # Move Ethernet packet back into eth_down
	    push(@{$self->{eth_down}}, [$eth_obj, $dest_ip]);
	    push(@{$self->{task}}, sub {$self->process_down()});
	    
	    # Remove from eth_wait
	    delete(${$self->{eth_wait}}[$_]);
	}
    }
}

1;
