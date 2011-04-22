package Packet::UDP;
#
# $Id: UDP.pm,v 1.15 2002/05/31 19:15:31 tcaine Exp $

use strict;

use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';

use Packet;
use NetPacket::UDP;
@ISA = qw/ Packet /;

#use overload '""' => sub { encode($_[0]) };


#  generate accessor/mutator methods
foreach ( qw( autogen_len autogen_cksum src_port dest_port len cksum data ) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
  my ($class, %args) = @_;

  my $self = {
    autogen_cksum	=> 1,
    autogen_len		=> 1,
    src_port		=> int(rand(2 ** 16)),
    dest_port		=> int(rand(2 ** 16)),
    len			=> 0,
    cksum		=> 0,
    data		=> '',
    %args,
  };
  
  return bless $self, ref($class) || $class;
}

sub encode {
    my ($self, $src_ip, $dest_ip) = @_;

    if ($self->{src_port} !~ /^\d+$/)  {
	$self->{src_port} = (getservbyname($self->{src_port}, "udp"))[2];
    }
    if ($self->{dest_port} !~ /^\d+$/) {
	$self->{dest_port} = (getservbyname($self->{dest_port}, "udp"))[2];
    }
    
    my $pkt = pack(
	'n			n
         n			n
         a*',
	$self->{src_port},	$self->{dest_port},
	$self->{len},           0,
	$self->{data}
	);
    
    if ($self->{autogen_len}) {
	my $len = length($pkt);
	substr($pkt, 4, 2) = pack("n", $len);
	$self->{len} = $len;
    } elsif ($self->{autogen_cksum}) {

	$src_ip = ip_to_int(host_to_ip($src_ip))  if $src_ip  =~ /\./;
	$dest_ip = ip_to_int(host_to_ip($dest_ip))  if $dest_ip  =~ /\./;
	
	my $packet = pack(
	    'a4                 a4
             n                  n
             n                  n
             n                  n
             a*',
	    $src_ip,            $dest_ip,
	    17,                 $self->{len},
	    $self->{src_port},  $self->{dest_port}, 
	    $self->{len},       0,
	    $self->{data});

	
	
	my $cksum = NetPacket::in_cksum($packet);
	#my $cksum = Packet::checksum($pkt);
	$self->{cksum} = $cksum;
    }
    substr($pkt, 6, 2) = $self->{cksum};

    my $udp = NetPacket::UDP->decode($pkt);
    $udp->{data} = $self->{data};
    $udp->{src_port} = $self->{src_port};
    $udp->{dest_port} = $self->{dest_port};

    $pkt = $udp->encode(
	{
	    src_ip => $src_ip,
	    dest_ip => $dest_ip
	});
	    
    return $pkt;
}

sub decode {
    my ($self, $pkt) = @_;
    
    $self->{autogen_cksum} = 0;
    $self->{autogen_len}   = 0;
    
    ($self->{src_port}, $self->{dest_port}, 
     $self->{len}, $self->{cksum}, $self->{data}
    ) = unpack("nnnna*", $pkt);
    return 1;
}

1;
__END__

=head1 NAME

Packet::UDP - generate, encode, decode, and dump UDP datagrams.  

=head1 SYNOPSIS

  use Packet::UDP;

  $u = Packet::UDP->new(
    src_port       => int(rand(2 ** 16),
    dest_port      => int(rand(2 ** 16),
    data           => '',
  );

  $raw_udp = $u->encode();

  $u = Packet::UDP->new();
  $u->decode($raw_udp); 

  print "ports: " . $u->src_port . ' -> ' . $u->dest_port . "\n";
  print "data:\n" . $u->data;

  print "packet dump:\n" . $u->hexdump($raw_udp) . "\n";

=head1 DESCRIPTION

Packet::UDP is an *all Perl* module for creating and manipulating UDP datagrams.  The packets created by this module are 768 compliant by default.  Each field in the UDP header can be set via the Packet::UDP object's constructor or
mutator methods.

=head1 HEADER STRUCTURE

   UDP Datagram Header Format (See [1])

     0                   1                   2                   3   
     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |          Source Port          |        Destination Port       |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |            Length             |            Checksum           |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

=head1 METHODS

In the calling sequences below, square brackets B<[]> indicate optional parameters.

=over 4

=item B<new> - create a new Packet::UDP object

    $obj = Packet::UDP->new([src_port  => $src_port,]
                            [dest_port => $dest_port,]
                            [len       => $length,]
                            [autogen_len => $true,]
                            [cksum     => $cksum,]
                            [autogen_cksum => $true,]);

This is the constructor for Packet::UDP objects.  A new object is returned upon success, and undef is returned upon failure.  Each argument has a corresponding accessor/mutator method of the same name which can be used to retrieve or set the value of an attribute after the object has been instantiated via C<new()>.

All arguments to Packet::UDP's constructor are optional.  The new object returned is given the following defaults in the absence of corresponding named arguments.

=over 4

=item

The default I<src_port> is a psuedo random number between 0 and 2^16 - 1

=item

The default I<dest_port> is a psuedo random number between 0 and 2^16 - 1

=item

The default I<len> is C<0>

=item

The default I<autogen_len> is C<1>

=item

The default I<cksum> is C<0>

=item

The default I<autogen_cksum> is C<1>

=back

=back

=over 4

=item B<encode> - encode a raw UDP packet

    $packet = $obj->encode();

This method creates a udp packet by encoding the UDP header attributes and packet data into its binary representation ready for transmission.  The object reference can also be stringified to get the raw encoded packet.

    #  object is automagically encoded before sending
    send(S, $obj, 0);

=back


=over 4

=item B<decode> - decode a raw UDP packet

    $obj->decode($packet);

    print "UDP packet has a source port of " . $obj->src_port . "\n";

This method decodes a binary UDP packet and stores the values found.  A true value is returned upon success, and an undefined value is returned upon failure.

=back


=over 4

=item B<src_port> - get or set the source port

=back


=over 4

=item B<dest_port> - get or set the destination port

=back


=over 4

=item B<len> - get or set the packet size in bytes

=back

=over 4

=item B<cksum> - get or set the packet checksum

=back


=head1 REFERENCES

S<[1]  Postel, J., "User Datagram Protocol,"    RFC 768,>
    USC/Information Sciences Institute, August 1980.

=head1 BUGS

None yet.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

