package Packet::IPv6;
#
# $Id: IPv6.pm,v 1.1 2002/05/09 06:20:40 tcaine Exp $

use strict;

use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';

use Packet::Lookup qw/ :ipv6 /;

use Packet;
@ISA = qw/ Packet /;

use overload '""' => sub { encode($_[0]) };


#  Object Methods

#  generate accessor methods
foreach ( qw( version class flow_label len auto_len next_header hop_limit src_ip dest_ip data ) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
  my ($class, %args) = @_;
  my $self = {
    version => 6,
    priority => 0,
    flow_label => 0,
    len => 0,
    auto_len => 1,
    next_header => 0,
    hop_limit => 0,
    src_ip => "0:0:0:0:0:0:0:0",
    dest_ip => "0:0:0:0:0:0:0:0",
    data => "",
    %args,
  };	

  return bless $self, ref($class) || $class;
}

sub encode {
  my ($self) = @_;

  $self->{src_ip}  = ipv6_to_int(host_to_ipv6($self->{src_ip}))  if $self->{src_ip}  =~ /\:/;
  $self->{dest_ip} = ipv6_to_int(host_to_ipv6($self->{dest_ip})) if $self->{dest_ip} =~ /\:/;

  $self->{flow_label} = substr("B32", pack("N", $self->{flow_label}), 12, 20);

  my $pkt = pack('C B20 n C C B128 B128 a*',
   ($self->{version} << 4) | $self->{priority}, $self->{flow_label},
   $self->{len}, $self->{next_header}, $self->{hop_limit}, 
   $self->{src_ip}, $self->{dest_ip},
   $self->{data}
  );

  if ($self->{auto_len}) {
    substr($pkt, 4, 2) = pack("n", length($pkt));
    $self->{len} = length($pkt);
  }

  return $pkt;
}

sub decode {
  my ($self, $pkt)  = @_;
  $self->{auto_len} = 0;

  (my $vfc, $self->{flow_label}, $self->{len}, $self->{next_header}, 
   $self->{hop_limit}, $self->{src_ip}, 
   $self->{dest_ip}) = unpack ('C B20 n C C B128 B128 a*', $pkt);

  $self->{version} = ($vfc & 0xf0) >> 4;
  $self->{len}     = $vfc & 0x0f;
  $self->{src_ip}  = int_to_ipv6($self->{src_ip});
  $self->{dest_ip} = int_to_ipv6($self->{dest_ip});

  return 1;
}


1;

__END__

=pod

=head1 NAME

Packet::IPv6 - generate, encode, and decode IPv6 packets.

=head1 SYNOPSIS

    use Packet::IPv6;

    $i = Packet::IPv6->new(
      src_ip    => 'FEDC:BA98:7654:3210:FEDC:BA98:7654:3210',
      dest_ip   => '1080:0:0:0:8:800:200C:417A',
      data      => 'FOO'
    );
    $raw_ipv6 = $i->encode();

    $i = Packet::IPv6->new();
    $i->decode($raw_ipv6); 

    print "ip addrs: " . $i->src_ip . ' -> ' . $i->dest_ip . "\n";
    print "data:\n" . $i->data;

    print "packet dump:\n" . $i->hexdump($raw_ipv6) . "\n";

=head1 DESCRIPTION

Packet::IPv6 is an *all Perl* module for creating and manipulating IPv6 packets.  The packets created by this module are RFC2460 compliant by default.  Each field in the IPv6 header can be set via the Packet::IPv6 object's constructor or mutator methods.

=head1 HEADER STRUCTURE

 IPv6 Header Format (See [1]).

      0                   1                   2                   3   
     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |Version| Traffic Class |           Flow Label                  |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |         Payload Length        |  Next Header  |   Hop Limit   |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                                                               |
    +                                                               +
    |                                                               |
    +                         Source Address                        +
    |                                                               |
    +                                                               +
    |                                                               |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                                                               |
    +                                                               +
    |                                                               |
    +                      Destination Address                      +
    |                                                               |
    +                                                               +
    |                                                               |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

=head1 METHODS


In the calling sequences below, square brackets B<[]> indicate optional parameters.

=over 4

=item B<new> - create a new Packet::IP object

    $obj = Packet::IP->new([version => $version,]
                           [priority => $priority,]
                           [flow_label => $flow_label,]
                           [len => $len,]
                           [auto_len => $true,]
                           [next_header => $next_header,]
                           [hop_limit  => $hop_limit,]
                           [src_ip => $src_ip,]
                           [dest_ip => $dest_ip,]
                           [data => "",]);

This is the constructor for Packet::IPv6 objects.  A new object is returned upon success, and undef is returned upon failure.  Each argument has a corresponding accessor/mutator method of the same name which can be used to retrieve or set the value of an attribute after the object has been instantiated via C<new()>.

All arguments to Packet::IPv6's constructor are optional.  The new object returned is given the following defaults in the absence of corresponding named arguments.

=over 4

=item

The default I<src_ip> is C<0:0:0:0:0:0:0:0>

=item

The default I<dest_ip> is C<0:0:0:0:0:0:0:0>

=item

The default I<version> is C<6>

=item

The default I<priority> is C<0>

=item

The default I<flow_label> is C<0>

=item

The default I<len> is C<0>

=item

The default I<next_header> is C<0>

=item

The default I<hop_limit> is C<0>

=item

The default I<data> is C<"">

=back

=back

=over 4

=item B<encode> - foobar...

more foobar....

=back

=over 4

=item B<decode> - foobar...

more foobar....

=back

=head1 REFERENCES

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

