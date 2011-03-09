package Packet::IP;
#
# $Id: IP.pm,v 1.16 2002/05/31 19:24:59 tcaine Exp $

use strict;

use vars qw/ $VERSION @ISA @EXPORT_OK %EXPORT_TAGS /;
$VERSION = '0.01';

use Packet::Lookup qw/ :ip /;
use Socket qw/ AF_INET /;

use Packet;
require Exporter;
@ISA = qw/ Exporter Packet /;

use overload '""' => sub { encode($_[0]) };

# IP type of service bits
sub IPTOS_LOWDELAY   () { 0x10 }
sub IPTOS_THROUGHPUT () { 0x08 }
sub IPTOS_RELIABILITY() { 0x04 }

# ECN TOS bits
sub IPTOS_CE  () { 0x01 }
sub IPTOS_ECT () { 0x02 }

# IP precedence bits
sub IPTOS_PREC_NETCONTROL      () { 0xe0 }  
sub IPTOS_PREC_INTERNETCONTROL () { 0xc0 }
sub IPTOS_PREC_CRITIC_ECP      () { 0xa0 }
sub IPTOS_PREC_FLASHOVERRIDE   () { 0x80 }
sub IPTOS_PREC_FLASH           () { 0x60 }
sub IPTOS_PREC_IMMEDIATE       () { 0x40 }
sub IPTOS_PREC_PRIORITY        () { 0x20 }
sub IPTOS_PREC_ROUTINE         () { 0x00 }

# IP options bits
sub IPOPT_COPIED ($) { $_[0] & 0x80 }
sub IPOPT_CLASS  ($) { $_[0] & 0x60 }
sub IPOPT_NUMBER ($) { $_[0] & 0x1f }

sub IPOPT_CONTROL   () { 0x00 }
sub IPOPT_RESERVED1 () { 0x20 }
sub IPOPT_DEBMEAS   () { 0x40 }
sub IPOPT_RESERVED2 () { 0x60 }

sub IPOPT_EOL () {  0 }
sub IPOPT_NOP () {  1 }
sub IPOPT_RR  () {  7 }
sub IPOPT_TS  () { 68 }

sub IPOPT_SECURITY () { 130 }
sub IPOPT_LSRR     () { 131 }
sub IPOPT_SATID    () { 136 }
sub IPOPT_SSRR     () { 137 }

sub IPOPT_OPTVAL () { 0 } 
sub IPOPT_OLEN   () { 1 }
sub IPOPT_OFFSET () { 2 }
sub IPOPT_MINOFF () { 4 }

%EXPORT_TAGS = (
    'all' => [qw/ IPTOS_LOWDELAY IPTOS_THROUGHPUT IPTOS_RELIABILITY IPTOS_CE 
        IPTOS_ECT IPTOS_PREC_NETCONTROL IPTOS_PREC_CRITIC_ECP IPTOS_PREC_FLASHOVERRIDE 
        IPTOS_PREC_FLASH IPTOS_PREC_IMMEDIATE IPTOS_PREC_PRIORITY IPTOS_PREC_ROUTINE 
        IPOPT_COPIED IPOPT_CLASS IPOPT_NUMBER IPOPT_CONTROL IPOPT_RESERVED1 IPOPT_DEBMEAS 
        IPOPT_RESERVED2 IPOPT_EOL IPOPT_NOP IPOPT_RR IPOPT_TS IPOPT_SECURITY IPOPT_LSRR 
        IPOPT_SATID IPOPT_SSRR IPOPT_OPTVAL IPOPT_OLEN IPOPT_OFFSET IPOPT_MINOFF /],
    'tos' => [qw/ IPTOS_LOWDELAY IPTOS_THROUGHPUT IPTOS_RELIABILITY IPTOS_CE IPTOS_ECT 
        IPTOS_PREC_NETCONTROL IPTOS_PREC_CRITIC_ECP IPTOS_PREC_FLASHOVERRIDE IPTOS_PREC_FLASH 
        IPTOS_PREC_IMMEDIATE IPTOS_PREC_PRIORITY IPTOS_PREC_ROUTINE /],
    'options' => [qw/ IPOPT_COPIED IPOPT_CLASS IPOPT_NUMBER IPOPT_CONTROL IPOPT_RESERVED1 
        IPOPT_DEBMEAS IPOPT_RESERVED2 IPOPT_EOL IPOPT_NOP IPOPT_RR IPOPT_TS IPOPT_SECURITY 
        IPOPT_LSRR IPOPT_SATID IPOPT_SSRR IPOPT_OPTVAL IPOPT_OLEN IPOPT_OFFSET IPOPT_MINOFF /],
);

@EXPORT_OK = @{$EXPORT_TAGS{all}};

#  Object Methods

#  generate accessor methods
foreach ( qw( autogen_cksum autogen_hlen autogen_len version hlen tos id foffset ttl proto cksum src_ip dest_ip options data ) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
  my $class = shift;
  my %param = &_param_parse;
  my $self = {
    autogen_cksum	=> 1,
    autogen_hlen	=> 1,
    autogen_len		=> 1,
    version		=> 4,
    hlen		=> 0,
    tos			=> 0x00,
    len			=> 0,
    id			=> int(rand(2 ** 16)),
    flags		=> 0,
    foffset		=> 0,
    ttl			=> 64,
    proto		=> 6,
    cksum		=> 0,
    src_ip		=> int_to_ip(int(rand(2 ** 32))),
    dest_ip		=> int_to_ip(int(rand(2 ** 32))),
    options		=> "",
    data		=> "",
    %param,
  };	
  return bless $self, ref($class) || $class;
}

sub _param_parse {
  my %args = @_;
  my %param;
  foreach (keys %args) {
    if    (/^-?autogen_cksum/i || /^-?auto_cksum/i)
                                { $param{autogen_cksum} = $args{$_} }
    elsif (/^-?autogen_hlen/i  || /^-?auto_hlen/i)
                                { $param{autogen_hlen}  = $args{$_} }
    elsif (/^-?autogen_len/i  || /^-?auto_len/i)
                                { $param{autogen_len}   = $args{$_} }
    elsif (/^-?version/i)       { $param{version}       = $args{$_} }
    elsif (/^-?hlen/i)          { $param{hlen}          = $args{$_} }
    elsif (/^-?tos/i)           { $param{tos}           = $args{$_} }
    elsif (/^-?len/i)           { $param{len}           = $args{$_} }
    elsif (/^-?id/i)            { $param{id}            = $args{$_} }
    elsif (/^-?flags/i)         { $param{flags}         = $args{$_} }
    elsif (/^-?foffset/i)       { $param{foffset}       = $args{$_} }
    elsif (/^-?ttl/i)           { $param{ttl}           = $args{$_} }
    elsif (/^-?proto/i)         { $param{proto}         = $args{$_} }
    elsif (/^-?cksum/i)         { $param{cksum}         = $args{$_} }
    elsif (/^-?src_ip/i)        { $param{src_ip}        = $args{$_} }
    elsif (/^-?dest_ip/i)       { $param{dest_ip}       = $args{$_} }
    elsif (/^-?options/i)       { $param{options}       = $args{$_} }
    elsif (/^-?data/i)          { $param{data}          = $args{$_} }
  }
  return %param;
}

sub encode {
  my ($self) = @_;

  $self->{src_ip}  = ip_to_int(host_to_ip($self->{src_ip}))  if $self->{src_ip}  =~ /\./;
  $self->{dest_ip} = ip_to_int(host_to_ip($self->{dest_ip})) if $self->{dest_ip} =~ /\./;

  $self->{foffset} = (
   substr(unpack("B8",  pack("C", $self->{flags})),   5, 3) .
   substr(unpack("B16", pack("n", $self->{foffset})), 3, 13)
  );

  $self->{hlen} = (5 + length($self->{options})) if $self->{autogen_hlen};

  my $pkt = pack(
   'C
    C			n
    n			B16
    C			C
    n			N
    N			a*',
   ($self->{version} << 4) | $self->{hlen},
    $self->{tos},	$self->{len},
    $self->{id},	$self->{foffset},
    $self->{ttl},	$self->{proto},
    $self->{cksum},	$self->{src_ip},
    $self->{dest_ip},	$self->{options} . $self->{data},
  );

  if ($self->{autogen_len}) {
    substr($pkt, 2, 2) = pack("n", length($pkt));
    $self->{len} = length($pkt);
  }

  if ($self->{autogen_cksum}) {
    my $pseudo = pack(
     'C
      C			n
      n			B16
      C			C
      n			N
      N',
     ($self->{version} << 4) | $self->{hlen},
      $self->{tos},	$self->{len},
      $self->{id},	$self->{foffset},
      $self->{ttl},	$self->{proto},
      0,		$self->{src_ip},
      $self->{dest_ip}
    );
    # Simon Trigona
    my $cksum = &ip_checksum($pseudo);
    substr($pkt, 10, 2) = pack("n", $cksum);
    $self->{cksum} = $cksum;
  }

  return $pkt;
}

sub decode {
  my ($self, $pkt) = @_;
  my ($w, $olen);

  $self->{autogen_cksum} = 0;
  $self->{autogen_hlen}  = 0;
  $self->{autogen_len}   = 0;

  ($w,			$self->{tos},
   $self->{len},	$self->{id},
   $self->{foffset},	$self->{ttl}, 
   $self->{proto},	$self->{cksum},
   $self->{src_ip},	$self->{dest_ip},
   $self->{options}	) = unpack(
  'C			C
   n			n
   B16			C
   C			n
   N			N
   a*', 		$pkt
  );

  $self->{version}	= ($w & 0xf0) >> 4;
  $self->{hlen}		= $w & 0x0f;

  $self->{flags}	= substr($self->{foffset}, 0, 3, '');
  $self->{flags}	= sprintf("%08d", $self->{flags});
  $self->{flags}	= unpack("C", pack("B8", $self->{flags}));
  $self->{foffset}	= sprintf("%016d", $self->{foffset});
  $self->{foffset}	= unpack("n", pack("B16", $self->{foffset}));

  $olen			= $self->{hlen} - 5;
  $olen			= 0, if ($olen < 0);
  ($self->{options}, $self->{data}) = unpack("a" . $olen . "a*", $self->{options});
  $self->{src_ip}  = int_to_ip($self->{src_ip});
  $self->{dest_ip} = int_to_ip($self->{dest_ip});
  return 1;
}

sub ip_checksum {
  my $pkt       = shift;
  my $len_msg   = length($pkt);
  my $num_short = $len_msg / 2; 
  my $chk       = 0;
  foreach my $short (unpack("S$num_short", $pkt)) {
    $chk += $short;
  }
  if ($len_msg % 2) {
    $chk += unpack("C", substr($pkt, $len_msg - 1, 1));
  }
  $chk = ($chk >> 16) + ($chk & 0xffff);
  return unpack("n", scalar reverse pack("n", (~(($chk >> 16) + $chk) & 0xffff)));
}


1;

__END__

=pod

=head1 NAME

Packet::IP - generate, encode, and decode IP packets.

=head1 SYNOPSIS

    use Packet::IP;

    $i = Packet::IP->new(
      src_ip    => '10.0.0.1',
      dest_ip   => '10.2.0.1',
      data      => 'FOO'
    );
    $raw_ip = $i->encode();

    $i = Packet::IP->new();
    $i->decode($raw_ip); 

    print "ip addrs: " . $i->src_ip . ' -> ' . $i->dest_ip . "\n";
    print "data:\n" . $i->data;

    print "packet dump:\n" . $i->hexdump($raw_ip) . "\n";

=head1 DESCRIPTION

Packet::IP is an *all Perl* module for creating and manipulating IP packets.  The packets created by this module are RFC791 compliant by default.  Each field in the IP header can be set via the Packet::IP object's constructor or mutator methods.

=head1 HEADER STRUCTURE

 IP Header Format (See [1]).

      0                   1                   2                   3   
     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |Ver= 4 |IHL= 5 |Type of Service|       Total Length = 472      |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |     Identification = 111      |Flg=0|     Fragment Offset = 0 |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |   Time = 123  | Protocol = 6  |        header checksum        |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                         source address                        |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                      destination address                      |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                             data                              |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

=head1 METHODS


In the calling sequences below, square brackets B<[]> indicate optional parameters.

=over 4

=item B<new> - create a new Packet::IP object

    $obj = Packet::IP->new([version => 4,]
                           [hlen    => 0,]
                           [autogen_hlen => 1,]
                           [tos     => 0x00,]
                           [len     => 0,]
                           [autogen_len => 1,]
                           [id      => int(rand(2 ** 16)),]
                           [flags   => 0,]
                           [foffset => 0,]
                           [ttl     => 64,]
                           [proto   => 6,]
                           [cksum   => 0,]
                           [autogen_cksum => 1,]
                           [src_ip => int_to_ip(int(rand(2 ** 32))),]
                           [dest_ip => int_to_ip(int(rand(2 ** 32))),]
                           [options => "",]
                           [data => "",]);

This is the constructor for Packet::IP objects.  A new object is returned upon success, and undef is returned upon failure.  Each argument has a corresponding accessor/mutator method of the same name which can be used to retrieve or set the value of an attribute after the object has been instantiated via C<new()>.

All arguments to Packet::IP's constructor are optional.  The new object returned is given the following defaults in the absence of corresponding named arguments.

=over 4

=item

The default I<src_ip> is a psuedo random IP address

=item

The default I<dest_ip> is a psuedo random IP address

=item

The default I<version> is C<4>

=item

The default I<hlen> is C<0>

=item

The default I<tos> is C<0x00>

=item

The default I<len> is C<0>

=item

The default I<id> is a psuedo random number between 0 and 2^32 - 1

=item

The default I<flags> is C<0>

=item

The default I<foffset> is C<0>

=item

The default I<ttl> is C<64>

=item

The default I<proto> is C<6>

=item

The default I<cksum> is C<0>

=item

The default I<options> is C<"">

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

S<[1]  Postel, J., "Internet Protocol - DARPA Internet Program Protocol Specification," RFC 791,>
    USC/Information Sciences Institute, September 1981.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

