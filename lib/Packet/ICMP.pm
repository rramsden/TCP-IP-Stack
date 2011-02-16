package Packet::ICMP;
#
# $Id: ICMP.pm,v 1.6 2002/05/01 07:26:37 cp5 Exp $

use strict;

use vars qw/ $VERSION @ISA @EXPORT_OK %EXPORT_TAGS /;
$VERSION = '0.01';

use Packet;
require Exporter;
@ISA = qw/ Packet Exporter /;

my @types = qw/ ICMP_ECHO_REPLY  ICMP_DEST_UNREACH  ICMP_SRC_QUENCH  ICMP_REDIRECT  
                ICMP_ECHO  ICMP_TIME_EXCEED ICMP_PARAM_PROBLEM  ICMP_TIMESTAMP  
                ICMP_TIMESTAMP_REPLY  ICMP_INFO_REQUEST  ICMP_INFO_REPLY /;

my @codes = qw/ ICMP_NET_UNREACH  ICMP_HOST_UNREACH  ICMP_PROTO_UNREACH  ICMP_FRAG_NEEDED  
                ICMP_SRC_ROUTE_FAILED ICMP_NETWORK  ICMP_HOST  ICMP_TOS_NETWORK  
                ICMP_TOS_HOST  ICMP_TTL_EXCEED  ICMP_FRAG_TIME_EXCEED /;

%EXPORT_TAGS = (
    all       => [@types, @codes],
    constants => [@types, @codes],
    types     => [@types],
    codes     => [@codes],
);

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

# ICMP Message Types
sub ICMP_ECHO_REPLY      () {  0 }
sub ICMP_DEST_UNREACH    () {  3 }
sub ICMP_SRC_QUENCH      () {  4 }
sub ICMP_REDIRECT        () {  5 }
sub ICMP_ECHO            () {  8 }
sub ICMP_TIME_EXCEED     () { 11 }
sub ICMP_PARAM_PROBLEM   () { 12 }
sub ICMP_TIMESTAMP       () { 13 }
sub ICMP_TIMESTAMP_REPLY () { 14 }
sub ICMP_INFO_REQUEST    () { 15 }
sub ICMP_INFO_REPLY      () { 16 }

# ECHO_REPLY Codes
sub ICMP_NET_UNREACH     () { 0 }
sub ICMP_HOST_UNREACH    () { 1 }
sub ICMP_PROTO_UNREACH   () { 2 }
sub ICMP_PORT_UNREACH    () { 3 }
sub ICMP_FRAG_NEEDED     () { 4 }
sub ICMP_SRC_ROUTE_FAILED() { 5 }

# REDIRECT Codes
sub ICMP_NETWORK         () { 0 }
sub ICMP_HOST            () { 1 }
sub ICMP_TOS_NETWORK     () { 2 }
sub ICMP_TOS_HOST        () { 3 }

# TIME_EXCEED Codes
sub ICMP_TTL_EXCEED      () { 0 }
sub ICMP_FRAG_TIME_EXCEED() { 1 }

# PARAM_PROBLEM Codes
sub ICMP_POINTER         () { 0 }


use overload '""' => sub { encode($_[0]) };


#  Object Methods

#  generate accessor methods
foreach ( qw( type code cksum data autogen_cksum ) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
  my ($class, %args) = @_;
  my $self = {
    autogen_cksum	=> 1,
    type		=> 8,
    code		=> 0,
    cksum		=> 0,
    data		=> "",
    %args
  };

  return bless $self, ref($class) || $class;
}

sub encode {
  my ($self) = @_;

  my $pkt = pack(
   'C			C
    n			a*',
    $self->{type},	$self->{code},
    $self->{cksum},	$self->{data}
  );
  if ($self->{autogen_cksum}) {      
    my $cksum = &icmp_checksum($pkt);
    substr($pkt, 2, 2) = pack("n", $cksum);
    $self->{cksum} = $cksum;
  }

  return $pkt;
}

sub decode {
  my ($self, $pkt) = @_;

  $self->{autogen_cksum} = 0;

  ($self->{type},	$self->{code},
   $self->{cksum},      $self->{data}) = unpack(
  'C			C
   n			a*', $pkt
  );

  return 1;
}

sub icmp_checksum {
  my $pkt       = shift();
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

=head1 NAME

Packet::ICMP - generate, encode, decode, and dump ICMP packets.

=head1 SYNOPSIS

  use Packet::ICMP;

  $i = Packet::ICMP->new(
    type     => 8,
    code     => 0,
    data     => join('', 'A' .. 'Z')
  );
  $raw_icmp = $i->encode();

  $i = Packet::ICMP->new();
  $i->decode($raw_icmp); 

  print "type: " . $i->type . "\n";
  print "code: " . $i->code . "\n";
  print "data: " . $i->data . "\n";

  print "packet dump:\n" . $i->hexdump($raw_icmp) . "\n";

=head1 DESCRIPTION

Packet::ICMP is an *all Perl* module for creating and manipulating ICMP packets.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

