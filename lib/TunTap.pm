# you will need to create a persistent Tap device before you can
# use attach()
package TunTap;
use Carp qw( croak );
use strict;
use IO::File;

use constant IFF_TUN   => 0x0001;
use constant IFF_TAP   => 0x0002;
use constant IFF_NO_PI => 0x1000; # we don't need the preamble
use constant TUN_MAX_FRAME => 4096;
use constant TUNSETIFF => 0x400454ca;
use constant STRUCT_IFREQ => 'Z16 s';
use constant TUNNEL_DEVICE => '/dev/net/tun';

# returns the file handle of existing tap/tun device
# eg. $fh = TunTap->attach(name => 'tap0')
sub attach {
  my ($class, %args) = @_;

  # parameters
  my $self = {
    name => '', # device name eg. tap0 
    type => IFF_TAP | IFF_NO_PI,
    %args
  };

  my $fd = new IO::File(TUNNEL_DEVICE, 'r+') 
    or croak "cannot open ".TUNNEL_DEVICE." : $!";
  
  my $ifr = pack(STRUCT_IFREQ, $self->{'name'}, $self->{'type'});
  ioctl $fd, TUNSETIFF, $ifr
    or croak "ioctl failed: $!";

  return $fd;
}
1;
