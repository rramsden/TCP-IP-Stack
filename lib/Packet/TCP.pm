package Packet::TCP;
#
# $Id: TCP.pm,v 1.25 2002/05/14 02:46:31 tcaine Exp $

use strict;

use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';

use Packet;
use NetPacket::TCP;
@ISA = qw/ Packet /;

use overload '""' => sub { encode($_[0]) };

#  generate accessor methods
foreach ( qw( autogen_cksum reserved autogen_hlen src_port dest_port seqnum acknum hlen urg ack psh rst syn fin winsize cksum urgp options data ) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
  my ($class, %args) = @_;

  my $self = {
    autogen_cksum => 1,
    autogen_hlen  => 1,
    src_port      => int(rand(2 ** 16)),
    dest_port     => int(rand(2 ** 16)),
    seqnum        => int(rand(2 ** 32)),
    acknum        => 0,
    hlen          => 5,
    reserved      => 0,
    # Flags
    cwr           => 0,
    ece           => 0,
    urg	          => 0,
    ack	          => 0,
    psh	          => 0,
    rst	          => 0,
    syn	          => 0,
    fin           => 0,
    # End Flags
    winsize       => int(rand(2 ** 16)),
    cksum         => 0,
    urgp          => 0,
    options       => "",
    data          => "",
    %args
  };	

  return bless $self, ref($class) || $class;
}

sub encode {
  my ($self, $src_ip, $dest_ip) = @_;

  my $flags = $self->{cwr} . $self->{ece} . $self->{urg} . $self->{ack} .
              $self->{psh} . $self->{rst} . $self->{syn} . $self->{fin};

  $self->{src_port}  = (getservbyname($self->{src_port},  "tcp"))[2] 
    if $self->{src_port}  !~ /^\d+$/;
  $self->{dest_port} = (getservbyname($self->{dest_port}, "tcp"))[2] 
    if $self->{dest_port} !~ /^\d+$/;

  $self->{hlen}      = (5 + length($self->{options})) if $self->{autogen_hlen};
  my $reserved       = substr(unpack("B8", pack("C", $self->{reserved})), 2, 6);
#  my $hlen           = substr(unpack("B8", pack("C", $self->{hlen})), 4, 4);
  my $hlen           = substr(unpack("B8", pack("C", $self->{hlen})), 4, 4); # not reversing
  
  my $pkt = pack(
      'n n N N B16 n n n a*',
      $self->{src_port},	$self->{dest_port},
      $self->{seqnum},	$self->{acknum},
      "${hlen}${reserved}${flags}",
      $self->{winsize},	$self->{cksum},
      $self->{urgp},	$self->{options} . $self->{data},
      );

  if ($self->{autogen_cksum}) {
    my $octets = 20 + length($self->{data});
    my $pseudo = pack('A4 A4 C C n', "0" x 8, "0" x 8, 0, 6, $octets);
    my $cksum = Packet::checksum($pseudo . $pkt . (length($pseudo . $pkt) % 2 ? chr(0) : ""));
    #substr($pkt, 16, 2, $cksum);
    $self->{cksum} = $cksum;
  }

  # HACK to get around bad checksum
  my $tcp = NetPacket::TCP->decode($pkt);
  $tcp->{data} = $self->{data};
  $tcp->{src_port} = $self->{src_port};
  $tcp->{dest_port} = $self->{dest_port};
  
  $pkt = $tcp->encode(
      {
	  src_ip => $src_ip,
	  dest_ip => $dest_ip
      });
  
  # End of HACK

  return $pkt;
}

sub decode {
  my ($self, $pkt) = @_;

  $self->{autogen_cksum} = 0;
  $self->{autogen_hlen}  = 0;

  my ($olen, $flags);
  ($self->{src_port}, $self->{dest_port}, $self->{seqnum}, $self->{acknum}, 
   $flags, $self->{winsize}, $self->{cksum}, $self->{urgp}, $self->{data}
  ) = unpack 'n n N N B16 n n n a*', $pkt;
  
  $self->{hlen} = substr $flags, 0, 4, '';
  $self->{reserved} = substr $flags, 0, 4, '';
 ($self->{cwr}, $self->{ece}, $self->{urg}, $self->{ack},
  $self->{psh}, $self->{rst}, $self->{syn}, $self->{fin}
 ) = split //, $flags;

  my $place = my $result = 0;
  foreach ( reverse $self->{hlen} =~ /(.)/g ) {
    $result += 2 ** $place++ * $1;
  }
  $self->{hlen} = unpack("C", pack("B8", sprintf("%08d", $self->{hlen})));
  $self->{reserved} = unpack("C", pack("B8", sprintf("%08d", $self->{reserved})));
  $olen = $result - 5;
  $olen = 0, if ($olen < 0);
  ($self->{options}, $self->{data}) = unpack("a" . $olen . "a*", $self->{data});
  return 1;
}

1;
__END__

=head1 NAME

Packet::TCP - create, encode, and decode TCP segments.

=head1 SYNOPSIS

  use Packet::TCP;

  $t = Packet::TCP->new(
    src_port => 35210,
    dest_port => 2000,
    fin => 1
  );

  $raw_tcp = $t->encode();
  
  ...

  $t = Packet::TCP->new();
  $t->decode($raw_tcp); 

  print "ports: " . $t->src_port . ' -> ' . $t->dest_port . "\n";
  print "data:\n" . $t->data;

  print "packet dump:\n" . $t->hexdump($raw_pkt) . "\n";

=head1 DESCRIPTION

Packet::TCP is an *all Perl* module for creating and manipulating TCP segments.  The packets created by this module are RFC793 compliant by default.  However each field in the TCP header can be set via the Packet::TCP object's constructor or mutator methods.

=head1 HEADER STRUCTURE

 TCP Header Format (See [1]).

    0                   1                   2                   3   
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |          Source Port          |       Destination Port        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                        Sequence Number                        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Acknowledgment Number                      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |  Data |           |U|A|P|R|S|F|                               |
   | Offset| Reserved  |R|C|S|S|Y|I|            Window             |
   |       |           |G|K|H|T|N|N|                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |           Checksum            |         Urgent Pointer        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Options                    |    Padding    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                             data                              |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

=head1 METHODS

In the calling sequences below, square brackets B<[]> indicate optional parameters.

=over 4

=item B<new> - create a new Packet::TCP object

    $obj = Packet::TCP->new([src_port  => $src_port,]
                            [dest_port => $dest_port,]
                            [seqnum    => $seqnum,]
                            [acknum    => $acknum,]
                            [hlen      => $hlen,]
                            [autogen_hlen => $true,]
                            [reserved  => $reserved,]
                            [urg       => $urg,]
                            [ack       => $ack,]
                            [psh       => $psh,]
                            [rst       => $rst,]
                            [syn       => $syn,]
                            [fin       => $fin,]
                            [winsize   => $winsize,]
                            [cksum     => $cksum,]
                            [autogen_cksum => $true,]
                            [urgp      => $urgp,]
                            [options   => $options,]
                            [data      => $data,]);

This is the constructor for Packet::TCP objects.  A new object is returned upon success, and undef is returned upon failure.  Each argument has a corresponding accessor/mutator method of the same name which can be used to retrieve or set the value of an attribute after the object has been instantiated via C<new()>.

All arguments to Packet::TCP's constructor are optional.  The new object returned is given the following defaults in the absence of corresponding named arguments.

=over 4

=item

The default I<src_port> is a psuedo random number between 0 and 2^16 - 1

=item

The default I<dest_port> is a psuedo random number between 0 and 2^16 - 1

=item

The default I<seqnum> is a psuedo random number  between 0 and 2^32 - 1

=item

The default I<acknum> is C<0>

=item

The default I<hlen> is C<5>

=item

The default I<autogen_hlen> is C<1>

=item

The default I<reserved> is C<0>

=item

The default I<urg> is C<0>

=item

The default I<ack> is C<0>

=item

The default I<psh> is C<0>

=item

The default I<rst> is C<0>

=item

The default I<syn> is C<0>

=item

The default I<fin> is C<0>

=item

The default I<winsize> is C<0>

=item

The default I<cksum> is C<0>

=item

The default I<autogen_cksum> is C<1>

=item

The default I<urgp> is C<0>

=item

The default I<options> is C<"">

=item

The default I<data> is C<"">

=back

=back


=over 4

=item B<encode> - encode a raw TCP packet

    $packet = $obj->encode();

This method creates a tcp packet by encoding the TCP header attributes and packet data into its binary representation ready for transmission.  The object reference can also be stringified to get the raw encoded packet.

    #  object is automagically encoded before sending
    send(S, $obj, 0);

=back


=over 4

=item B<decode> - decode a raw TCP packet    

    $obj->decode($packet);

    print "TCP packet has a source port of " . $obj->src_port . "\n";

This method decodes a binary TCP packet and stores the values found.  A true value is returned upon success, and an undefined value is returned upon failure.

=back


=over 4

=item B<src_port> - get or set the source port

=back


=over 4

=item B<dest_port> - get or set the destination port

=back


=over 4

=item B<seqnum> - get or set the TCP sequence number

=back

=over 4

=item B<acknum> - get or set the TCP acknowledgment number

If the ACK control bit is set this field contains the value of the next sequence number the sender of the segment is expecting to receive.  Once a connection is established this is always sent.

=back

=over 4

=item B<hlen> - get or set the TCP header's data offset

This is the number of 32 bit words in the TCP header.  This indicates where the data begins.

=back

=over 4

=item B<reserved> - get or set the reserved TCP header bits

This field is reserved for future use and is usually set to C<0>.

=back

=over 4

=head2 TCP CONTROL BITS

=over 4

=item B<urg> - get or set the URG control bit

Urgent Pointer field significant

=back

=over 4

=item B<ack> - get or set the ACK control bit

Acknowledgment field significant

=back

=over 4

=item B<psh> - get or set the PSH control bit

Push Function

=back

=over 4

=item B<rst> - get or set the RST control bit

Reset the connection

=back

=over 4

=item B<syn> - get or set the SYN control bit

Synchronize sequence numbers

=back

=over 4

=item B<fin> - get or set the FIN control bit

No more data from sender

=back

=back


=over 4

=item B<winsize> - get or set the window size

This is the number of data octets the segment is willing to accept.

=back


=over 4

=item B<cksum> - get or set the packet checksum

The checksum is calculated automatically at the time of packet I<encode()>ing by default.  You can set the C<autogen_cksum> attribute to false if you would like to manually supply a checksum for the packet, otherwise any checksum that was supplied will be overwritten upon I<encode()>ing.

=back


=over 4

=item B<urgp> - get or set the urgent pointer

This field is only used in conjunction with the C<URG> TCP Control bit.  See RFC793 for more detail.

=back


=over 4

=item B<options> - get or set the TCP options field

Options may occupy space at the end of the TCP header and are multiple of 8 bits in length.

=back


=over 4

=item B<data> - get or set the payload of the TCP packet.

This is the payload of the TCP packet.

=back


=head1 REFERENCES

S<[1]     Postel,    J.,   "Transmission   Control   Protocol,"   RFC 761,>
    USC/Information Sciences Institute, January 1980.

=head1 BUGS

TCP option padding isn't currently implemented.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

L<Packet.pm>

=cut

