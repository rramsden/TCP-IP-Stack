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
foreach ( qw( type code cksum identifier group key autogen_cksum ) ) {
    eval "sub $_ () { (\@_ > 1) ? \$_[0]->{$_} = \$_[1] : \$_[0]->{$_} }";
}

sub new {
    my ($class, %args) = @_;
    my $self = {
	autogen_cksum	=> 1,
	type		=> 1,
	code		=> 0,
	cksum		=> 0,
	identifier      => 0,
	group		=> '127.0.0.1',
	key             => 0,
	%args
    };
    print "IGMP is not to spec...\n";
    return bless $self, ref($class) || $class;
}

sub encode {
    my ($self) = @_;
    
    $self->{group} = ip_to_int(host_to_ip($self->{group})) if $self->{group} =~ /\./;
    
    my $pkt = pack(
	'C                      C
         n                      N
         N                      N',# key is not packed properly
	$self->{type},   	$self->{code},
  	0,              	$self->{identifier},
	$self->{group},         $self->{key}
	);
    if ($self->{autogen_cksum}) {
	$self->{cksum} = &igmp_checksum($pkt);
    }
    substr($pkt, 2, 2) = $self->{cksum};
    
    return $pkt;
}

sub decode {
    my ($self, $pkt) = @_;
    
    $self->{autogen_cksum} = 0;
    
    ($self->{type},   	$self->{code},
     0,              	$self->{identifier},
     $self->{group},         $self->{key}) = unpack(
	'C			C
         n			N
         N                      N', $pkt
	 );
    
    $self->{group} = int_to_ip($self->{group});
    
    return 1;
}

sub igmp_checksum {
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

