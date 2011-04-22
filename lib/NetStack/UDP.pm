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
	my_ip    => "192.168.1.100",
	udp_up   => [],
	udp_down => [],
	ip_down  => [],
	ip_p     => sub {},
	stdout   => [],
	stdout_p => sub {},
	task     => [],
	ports    => {},
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
    
    my $callback = $self->{ports}->{$udp_obj->{dest_port}};
    if  (!defined $callback){
	return; # There is no service on that port.
    }

    push(@{$self->{task}}, sub {$callback->($src_ip, $udp_obj->{src_port}, $udp_obj->{data})});
    
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
    $ip_obj->{data} = $udp_obj->encode($self->{my_ip}, $dest_ip);
    
    push(@{$self->{ip_down}}, $ip_obj);
    push(@{$self->{task}}, $self->{ip_p});
}

1;
