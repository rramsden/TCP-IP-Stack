package Packet::Ethernet;
#
# $Id: Ethernet.pm,v 1.6 2002/05/08 20:03:44 cp5 Exp $

use strict;

use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';

use Packet;
@ISA = qw/ Packet /;

use overload '""' => sub { encode($_[0]) };


use Packet::Lookup qw/ :mac /;

#  Object Methods

#  generate accessor methods
foreach ( qw( src_mac dest_mac type data) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
  my ($class, %args) = @_;
  my $olen;
  my $self = {
    src_mac	=> 'ffffffffffff',
    dest_mac	=> 'ffffffffffff',
    type	=> 0x0806,
    data        => '',
    %args
  };	

  return bless $self, ref($class) || $class;
}

sub encode {
  my ($self) = @_;

  $self->{src_mac}  = to_mac($self->{src_mac})  if $self->{src_mac}  =~ /:/;
  $self->{dest_mac} = to_mac($self->{dest_mac}) if $self->{dest_mac} =~ /:/;

  my $pkt = pack(
   'H12			H12			n		a*',
    $self->{dest_mac},	$self->{src_mac},	$self->{type},	$self->{data}
  );

  return $pkt;
}

sub decode {
  my ($self, $pkt) = @_;

  ($self->{dest_mac},	$self->{src_mac},
  $self->{type},	$self->{data}) = unpack(
  'H12			H12
   n			a*', $pkt
  );

  return 1;
}


1;
__END__

=head1 NAME

Packet::Ethernet - generate, encode, decode, and dump Ethernet packets.

=head1 SYNOPSIS

  use Packet::Ethernet;

  $i = Packet::Ethernet->new(
    src_mac  => 'a0:b1:c2:d3:e4:f5',
    dest_mac => 'ff:ff:ff:ff:ff:ff',
    type     => 0x0806,
    data     => '',
  );
  $raw_eth = $i->encode();

  $i = Packet::Ethernet->new();
  $i->decode($raw_eth); 

  print "eth addrs: " . $i->src_mac . ' -> ' . $i->dest_mac . "\n";
  print "type: " . $i->type . "\n";

  print "packet dump:\n" . $i->hexdump($raw_eth) . "\n";

=head1 DESCRIPTION

Packet::Ethernet is an *all Perl* module for creating and manipulating Ethernet packets.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

