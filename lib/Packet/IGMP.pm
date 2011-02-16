package Packet::IGMP;
#
# $Id: IGMP.pm,v 1.10 2002/05/09 05:16:55 tcaine Exp $

use strict;

use vars qw/ $VERSION @ISA @EXPORT_OK %EXPORT_TAGS /;
$VERSION = '0.01';

use Packet;
require Exporter;
@ISA = qw/ Packet Exporter /;

my @types = qw/ IGMP_MEMBERSHIP_QUERY  IGMP_MEM_REPORT_V1  IGMP_MEM_REPORT_V2  IGMP_LEAVE_GROUP /;

%EXPORT_TAGS = (
    all       => [@types],
    constants => [@types],
    types     => [@types],
);

use Packet::Lookup qw/ :ip /;

# IGMP Types
sub IGMP_MEMBERSHIP_QUERY () { 17 }
sub IGMP_MEM_REPORT_V1    () { 18 }
sub IGMP_MEM_REPORT_V2    () { 22 }
sub IGMP_LEAVE_GROUP      () { 23 }

use overload '""' => sub { encode($_[0]) };


#  Object Methods

#  generate accessor methods
foreach ( qw( type version group unused cksum autogen_cksum ) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
  my ($class, %args) = @_;
  my $self = {
    autogen_cksum	=> 1,
    version		=> 1,
    type		=> 1,
    cksum		=> 0,
    unused		=> 0,
    group		=> '127.0.0.1',
    %args
  };

  return bless $self, ref($class) || $class;
}

sub encode {
  my ($self) = @_;

  $self->{group} = ip_to_int(host_to_ip($self->{group})) if $self->{group} =~ /\./;

  my $pkt = pack(
   'C
    C			n
    N',
   ($self->{version} << 4) | $self->{type},
    $self->{unused},	$self->{cksum},
    $self->{group}
  );
  if ($self->{autogen_cksum}) {      
    my $cksum = Packet::checksum($pkt);
    substr($pkt, 2, 2) = $cksum;
    $self->{cksum} = $cksum;
  }

  return $pkt;
}

sub decode {
  my ($self, $pkt) = @_;
  my $w;

  $self->{autogen_cksum} = 0;

  ($w,			$self->{unused},
   $self->{cksum},      $self->{group}) = unpack(
  'C			C
   n			N', $pkt
  );

  $self->{version}      = ($w & 0xf0) >> 4;
  $self->{type}         = $w & 0x0f;
  $self->{group}	= int_to_ip($self->{group});

  return 1;
}

1;
__END__

=head1 NAME

Packet::ICMP - generate, encode, decode, and dump IGMP packets.

=head1 SYNOPSIS

  use Packet::IGMP;

  $i = Packet::IGMP->new(
    version  => 1,
    type     => 2,
    group    => '127.0.0.1'
  );
  $raw_igmp = $i->encode();

  $i = Packet::IGMP->new();
  $i->decode($raw_igmp); 

  print "version: " . $i->version . "\n";
  print "type: "    . $i->type    . "\n";
  print "group: "   . $i->group   . "\n";

  print "packet dump:\n" . $i->hexdump($raw_igmp) . "\n";

=head1 DESCRIPTION

Packet::IGMP is an *all Perl* module for creating and manipulating IGMP packets.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

