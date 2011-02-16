package Packet::Device;
#
# $Id: Device.pm,v 1.1 2002/05/02 08:22:21 cp5 Exp $

use strict;
use Packet::Definitions;
   
use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';
  
use Packet;
@ISA = qw/ Packet /;


# Return the name of a network interface attached to the system, or NULL
# if none can be found.  The interface must be configured up; the
# lowest unit number is preferred; loopback is ignored.
#
sub lookupdev {
#        pcap_if_t *alldevs;
  my $if_namesize = &Packet::Definitions::IF_NAMESIZE;

  # for old BSD systems, including bsdi3
  $if_namesize |= &Packet::Definitions::IFNAMSIZ;


#        static char device[IF_NAMESIZE + 1];
#        char *ret;
  my $alldevs;
  unless ($alldevs = findalldevs()) {
    return 0;
  }
#        if (pcap_findalldevs(&alldevs, errbuf) == -1)
#                return (NULL);

  if ($#$alldevs == -1 || ($alldevs->{flags} & &Packet::Definitions::PCAP_IF_LOOPBACK)) {
    # There are no devices on the list, or the first device
    # on the list is a loopback device, which means there
    # are no non-loopback devices on the list.  This means
    # we can't return any device.
    #
    # XXX - why not return a loopback device?  If we can't
    # capture on it, it won't be on the list, and if it's
    # on the list, there aren't any non-loopback devices,
    # so why not just supply it as the default device?
    return 0;
  }
  else {
    # return the name of the first device on the list
    return $alldevs->{name};
  }
#        if (alldevs == NULL || (alldevs->flags & PCAP_IF_LOOPBACK)) {
#                (void)strlcpy(errbuf, "no suitable device found",
#                    PCAP_ERRBUF_SIZE);
#                ret = NULL;
#        } else {   
#                /*
#                 * Return the name of the first device on the list.
#                 */
#                (void)strlcpy(device, alldevs->name, sizeof(device));
#                ret = device;
#        }
#        pcap_freealldevs(alldevs);
#        return (ret);
}

sub findalldevs {
}


1;
__END__

=head1 NAME

Packet::Device - functions to retrieve network and network device information

=head1 SYNOPSIS

  use Packet::Device;

  $network_device = lookupdev();

=head1 DESCRIPTION

Packet::Device is a portable, *all Perl* module for retrieving network and device information.

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm

=cut

