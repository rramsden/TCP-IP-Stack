package Packet::Lookup;
#
# $Id: Lookup.pm,v 1.8 2002/05/09 06:14:02 tcaine Exp $

use strict;

use vars qw/ $VERSION @ISA @EXPORT_OK %EXPORT_TAGS /;
$VERSION = '0.01';

use Socket qw/ AF_INET /;

require Exporter;
@ISA = qw/ Exporter /;

%EXPORT_TAGS = (
    'all'  => [qw/ int_to_ip ip_to_int ip_to_host host_to_ip to_mac 
                   ipv6_to_int int_to_ipv6 ipv6_to_host host_to_ipv6 /],
    'ip'   => [qw/ int_to_ip ip_to_int ip_to_host host_to_ip /],
    'ipv6' => [qw/ ipv6_to_int int_to_ipv6 ipv6_to_host host_to_ipv6 /],
    'mac'  => [qw/ to_mac /],
);

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

# IP Version 4
sub ip_to_int  ($) { unpack("N", pack("C4", split(/\./, $_[0]))) }
sub int_to_ip  ($) { join(".", unpack("C4", pack("N", $_[0])))   }
sub ip_to_host ($) { (gethostbyaddr(pack("N", &ip_to_int($_[0])), AF_INET))[0] || $_[0] }
sub host_to_ip ($) { join(".", unpack("C4", ((gethostbyname($_[0]))[4]) || return $_[0])) }

# IP Version 6
sub ipv6_to_int  ($) { $_[0] }
sub int_to_ipv6  ($) { $_[0] }
sub ipv6_to_host ($) { $_[0] }
sub host_to_ipv6 ($) { $_[0] }


sub to_mac ($) {
 my ($mac) = @_;
 my $newmac;
 foreach (split(/:/, $mac)) {
  if (length($_) == 1) {
   $newmac .= 0 . $_;
  }
  else {
   $newmac .= $_;
  }
 }
 return $newmac;
}


1;
__END__

=head1 NAME

Packet::Lookup - packet conversion routines

=head1 SYNOPSIS

To be added...

=head1 DESCRIPTION

Packet::Lookup provides a set of routines that manipulate Packet header information.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

