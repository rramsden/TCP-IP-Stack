package Packet::Inject;
#
# $Id: Inject.pm,v 1.13 2002/05/02 08:22:21 cp5 Exp $

use strict;
use Packet::Definitions;

use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';

use Packet;
@ISA = qw/ Packet /;

sub new {
  my ($class, %args) = @_;
  my $self = {
   filter	=> 'bpf', # have to add function to find a filter automagically
   device	=> '',    # have to add function to find a device automagically
   %args
  };

  return bless $self, ref($class) || $class;
}

# open methods
sub open_bpf {
  my ($self) = @_;

  if (defined(&Packet::Definitions::BIOCGHDRCMPLT) && defined(&Packet::Definitions::BIOCSHDRCMPLT)) {
    $self->{spoof_eth_src} = pack("I", 1);
  }

  unless (opendir(DEV, "/dev")) {
    $self->{errbuf} = "opendir: /dev: $!\n";
    return 0;
  }
  my @bpf = grep { /^bpf/ } readdir(DEV);
  closedir(DEV);
  foreach (sort(@bpf)) {
    open($self->{fd}, "+</dev/$_") && last;
  }

  # Get BPF version
  my $bv;
  unless (ioctl($self->{fd}, &Packet::Definitions::BIOCVERSION, $bv)) {
    $self->{errbuf} = "BIOCVERSION (" . &Packet::Definitions::BIOCVERSION . "): $!";
    close($self->{fd});
    return 0;
  }

  my ($minor, $major) = unpack('SS', $bv);   
  if ($major != &Packet::Definitions::BPF_MAJOR_VERSION || $minor < &Packet::Definitions::BPF_MINOR_VERSION) {
    $self->{errbuf} = "kernel bpf filter out of date";
    close($self->{fd});
    return 0;
  }

  # Attach network interface to bpf device
  my $ifr = pack('a16@48', $self->{device});
  unless (ioctl($self->{fd}, &Packet::Definitions::BIOCSETIF, $ifr)) {
    $self->{errbuf} = "$self->{device} (BIOCSETIF: " . &Packet::Definitions::BIOCSETIF . "): $!\n";
    close($self->{fd});
    return 0;
  }

  # Get the data link layer type
  my $v;
  unless (ioctl($self->{fd}, &Packet::Definitions::BIOCGDLT, $v)) {
    $self->{errbuf} = "BIOCGDLT: $!\n";
    close($self->{fd}); 
    return 0;
  }

  # NetBSD and FreeBSD BPF have an ioctl for enabling/disabling
  # automatic filling of the link level source address
  if (defined(&Packet::Definitions::BIOCGHDRCMPLT) && defined(&Packet::Definitions::BIOCSHDRCMPLT)) {
    unless (ioctl($self->{fd}, &Packet::Definitions::BIOCSHDRCMPLT, $self->{spoof_eth_src})) {
      $self->{errbuf} = "BIOCSHDRCMPLT: $!\n";
      close($self->{fd});
      return 0;
    }
  }

  # Assign link type and offset
  if ($v == &Packet::Definitions::DLT_SLIP) {
    $self->{linkoffset} = 0x10;
  }
  elsif ($v == &Packet::Definitions::DLT_RAW) {
    $self->{linkoffset} = 0x0;
  }
  elsif ($v == &Packet::Definitions::DLT_PPP) {
    $self->{linkoffset} = 0x04;
  }
  elsif ($v == &Packet::Definitions::DLT_EN10MB) {
    $self->{linkoffset} = 0xe;
  }
  else { # default to ethernet
    $self->{linkoffset} = 0xe;
  }
  if (defined(&Packet::Definitions::_BSDI_VERSION) && &Packet::Definitions::_BSDI_VERSION >= 199510) {
    if ($v == &Packet::Definitions::DLT_SLIP) {
      $v = &Packet::Definitions::DLT_SLIP_BSDOS;
      $self->{linkoffset} = 0x10;
    }
    elsif ($v == &Packet::Definitions::DLT_PPP) {
      $v = &Packet::Definitions::DLT_PPP_BSDOS;
      $self->{linkoffset} = 0x04;
    }
  }
  $self->{linktype} = $v;

  return 1;
}
sub open_nit {
  my ($self) = @_;

  unless (socket($self->{fd}, &Packet::Definitions::AF_INET, &Packet::Definitions::SOCK_RAW, &Packet::Definitions::NITPROTO_RAW)) {
    $self->{errbuf} = "socket: $!\n";
    return 0;
  }
  unless (bind($self->{fd}, &Packet::Definitions::sockaddr_nit(&Packet::Definitions::AF_INET, "", $self->{device}))) {
    $self->{errbuf} = "bind: $self->{device}: $!\n";
    close($self->{fd});
    return 0;
  }

  # NIT only supports Ethernet
  $self->{linktype} = &Packet::Definitions::DLT_EN10MB;

  return 1;
}
sub open_snit {
  my ($self) = @_;
  my $dev = "/dev/nit";

  unless (open($self->{fd}, "<+$dev")) {
    $self->{errbuf} = "open: $dev: $!\n";
    return 0;
  }

  # Arrange to get discrete messages from the STREAM and use NIT_BUF
  unless (ioctl($self->{fd}, &Packet::Definitions::I_SRDOPT, &Packet::Definitions::RMSGD)) {
    $self->{errbuf} = "I_SRDOPT: $!\n";
    close($self->{fd});
    return 0;
  }
  unless (ioctl($self->{fd}, &Packet::Definitions::I_PUSH, "nbuf")) {
    $self->{errbuf} = "push nbuf: $!\n";
    close($self->{fd});
    return 0;
  }

  # Request the interface
  my $ifr = &Packet::Definitions::ifreq($self->{device});
  $ifr =~ s/.$/ /;
  my $si = &Packet::Definitions::strioctl(&Packet::Definitions::NIOCBIND, "", &Packet::Definitions::sizeof("ifreq"), $ifr);
  unless (ioctl($self->{fd}, &Packet::Definitions::I_STR, $si)) {
    $self->{errbuf} = "NIOCBIND: $self->{device}: $!\n";
    close($self->{fd});
    return 0;
  }

  ioctl($self->{fd}, &Packet::Definitions::I_FLUSH, &Packet::Definitions::FLUSHR);

  # NIT only supports Ethernet
  $self->{linktype} = &Packet::Definitions::DLT_EN10MB;

  return 1;
}
sub open_sockpacket {
  my ($self) = @_;

  my $HAVE_PF_PACKET = 0;
  if (defined(&Packet::Definitions::PF_PACKET)) {
    $HAVE_PF_PACKET = 1;
  }

  if ($HAVE_PF_PACKET) {
    unless (socket(SOCK, &Packet::Definitions::PF_PACKET, &Packet::Definitions::SOCK_RAW, ?)) {
      $self->{errbuf} = "socket: $!\n";
      return 0;
    }
  }
  else {
    unless (socket(SOCK, &Packet::Definitions::PF_INET, &Packet::Definitions::SOCK_PACKET, ?)) {
      $self->{errbuf} = "socket: $!\n";
      return 0;
    }
  }

  if ($HAVE_PF_PACKET) {
    my $ifr = &Packet::Definitions::ifreq({ifr_name => "$self->{device}\0"});
    my $mr  = &Packet::Definitions::unp_packet_mreq();
    unless (ioctl($self->{fd}, &Packet::Definitions::SIOCGIFINDEX, $ifr)) {
      $self->{errbuf} = "SIOCGIFINDEX $self->{device}: $!\n";
      close($self->{fd});
      return 0;
    }    

    $ifr = &Packet::Definitions::unp_ifreq($ifr);
    $mr->{mr_ifindex}	= $ifr->{ifr_ifindex};
    $mr->{mr_type}	= &Packet::Definitions::PACKET_MR_ALLMULTI;
    $mr			= &Packet::Definitions::packet_mreq($mr);
    unless (setsockopt($self->{fd}, &Packet::Definitions::SOL_PACKET, &Packet::Definitions::PACKET_ADD_MEMBERSHIP, $mr)) {
      $self->{errbuf} = "setsockopt $self->{device}: $!\n";
      close($self->{fd});
      return 0;
    }
  }

  my $ifr = &Packet::Definitions::ifreq({ifr_name => $self->{device}});
  unless (ioctl($self->{fd}, &Packet::Definitions::SIOCGIFHWADDR, $ifr)) {
    $self->{errbuf} = "SIOCGIFHWADDR: $!\n";
    close($self->{fd});
    return 0;
  }

  $ifr = &Packet::Definitions::unp_ifreq($ifr);
  if (
   $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_ETHER ||
   $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_METRICOM ||
   (
    defined(&Packet::Definitions::ARPHRD_LOOPBACK) &&
    $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_LOOPBACK
   )
  ) {
    $self->{linktype} = &Packet::Definitions::DLT_EN10MB;
    $self->{linkoffset} = 0xe;
  }
  elsif (
   $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_SLIP ||
   $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_CSLIP ||
   $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_SLIP6 ||
   $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_CSLIP6 ||
   $ifr->{ifr_hwaddr}{sa_family} == &Packet::Definitions::ARPHRD_PPP
  ) {
    $self->{linktype} = &Packet::Definitions::DLT_RAW;
  }
  else {
    $self->{errbuf} = "unknown physical layer type 0x$ifr->{ifr_hwaddr}{sa_family}\n";
    close($self->{fd});
    return 0;
  }

  return 1;
}


# close methods
sub close_bpf {
  my ($self) = @_;
  return (close($self->{fd}));
}
sub close_nit {
  my ($self) = @_;
  return (close($self->{fd}));
}
sub close_snit {
  my ($self) = @_;
  return (close($self->{fd}));
}
sub close_sockpacket {
  my ($self) = @_;
  return (close($self->{fd}));
}


# write methods
sub write_bpf {
  my ($self, %args) = @_;
  my $bytes = 0;
  $args{times} = 1 unless $args{times};

  if ($args{length}) {
    while ($args{times}--) {
      $bytes += syswrite($self->{fd}, $args{packet}, $args{length});
    }
  }

  else {
    while ($args{times}--) {
      $bytes += syswrite($self->{fd}, $args{packet});
    }
  }

  return $bytes;
}
sub write_nit {
  my ($self, %args) = @_;
  my $bytes = 0;
  my $sockaddr = &Packet::Definitions::sockaddr({sa_data => $self->{device}});
  $args{times} = 1 unless $args{times};

  if ($args{length}) {
    while ($args{times}--) {
      $bytes += send($self->{fd}, $args{packet}, $args{length}, $sockaddr);
    }
  }

  else {
    while ($args{times}--) {
      $bytes += send($self->{fd}, $args{packet}, length($args{packet}), $sockaddr);
    }
  }

  return $bytes;
}
sub write_snit {
  my ($self, %args) = @_;
  my $bytes = 0;
  my $sockaddr = &Packet::Definitions::sockaddr({sa_data => $self->{device}});
  $args{times} = 1 unless $args{times};

  if ($args{length}) {
    while ($args{times}--) {
      $bytes += send($self->{fd}, $args{packet}, $args{length}, $sockaddr);
    }
  }

  else {
    while ($args{times}--) {
      $bytes += send($self->{fd}, $args{packet}, length($args{packet}), $sockaddr);
    }
  }

  return $bytes;
}
sub write_sockpacket {
  my ($self, %args) = 2_;

  my $sockaddr;
  my $bytes = 0;
  my $HAVE_PF_PACKET = 0;
  $args{times} = 1 unless $args{times};

  if (defined(&Packet::Definitions::PF_PACKET)) {
    $HAVE_PF_PACKET = 1;
  }
  if ($HAVE_PF_PACKET) {
    my $ifr = &Packet::Definitions::ifreq({ifr_name => "$self->{device}\0"});
    $sockaddr = &Packet::Definitions::unp_sockaddr_ll();

    unless (ioctl($self->{fd}, &Packet::Definitions::SIOCGIFINDEX, $ifr)) {
      $self->{errbuf} = "SIOCGIFINDEX $self->{device}: $!\n";
      close($self->{fd});
      return 0;
    }

    $ifr = &Packet::Definitions::unp_ifreq($ifr);
    $sockaddr->{sll_ifindex}  = $ifr->{ifr_ifindex};
    $sockaddr->{sll_family}   = &Packet::Definitions::AF_PACKET;
    $sockaddr->{sll_protocol} = pack("n", &Packet::Definitions::ETH_P_ALL);

    $sockaddr = &Packet::Definitions::sockaddr($sockaddr);
  }
  else {
    $sockaddr = &Packet::Definitions::sockaddr({sa_data => $self->{device}});
  }

  if ($args{length}) {
    while ($args{times}--) {
      $bytes += send($self->{fd}, $args{packet}, $args{length}, $sockaddr);
    }
  }

  else {
    while ($args{times}--) {
      $bytes += send($self->{fd}, $args{packet}, length($args{packet}), $sockaddr);
    }
  }

  return $bytes;
}


# this will be very cool when using the ::Defs::ifreq and unp_ifreq functions
sub get_hwaddr_bpf {
  my ($self) = @_;

  my $len = pack('I', 0);
  my @mib = (
	&Packet::Definitions::CTL_NET,
	&Packet::Definitions::AF_ROUTE,
	0,
	&Packet::Definitions::AF_LINK,
	&Packet::Definitions::NET_RT_IFLIST,
	0
  );
  my $mib = pack('iiiiii', @mib);
  if (syscall(&Packet::Definitions::SYS___sysctl, $mib, 6, 0, $len, 0, 0) == -1) {
    return 0;
  }

  my $buf = pack('a' . unpack('I', $len), '');
  if (syscall(&Packet::Definitions::SYS___sysctl, $mib, 6, $buf, $len, 0, 0) == -1) {
    return 0;
  }

  my $tlen = unpack('I', $len);
  $buf =~ /^(.*?)\w{2,5}\d{1}/;
  my $val = (length($1) - 5);

#struct if_msghdr {
#        u_short ifm_msglen;     /* to skip over non-understood messages */
#        u_char  ifm_version;    /* future binary compatability */
#        u_char  ifm_type;       /* message type */
#        int     ifm_addrs;      /* like rtm_addrs */
#        int     ifm_flags;      /* value of if_flags */
#        u_short ifm_index;      /* index for associated ifp */
#        struct  if_data ifm_data;/* statistics and other data about if */
#};

  my ($msglen, $nlen, $dv);
  for (my $i = 0; $i < $tlen; $i += $msglen) {
   ($msglen, $nlen, $dv) = unpack("S x$val C x2 a12", substr($buf, $i));
   my $devname = sprintf("%s", substr($dv, 0, $nlen));
   my $mac = sprintf("%x:%x:%x:%x:%x:%x", unpack('CCCCCC', substr($dv, $nlen, 6)));

   $self->{devs}{$devname} = $mac;
 }

 return 1;
}
#    end = buf + len;
#    for (next = buf ; next < end ; next += ifm->ifm_msglen)
#    {   
#        ifm = (struct if_msghdr *)next;
#        if (ifm->ifm_type == RTM_IFINFO)
#        {   
#            sdl = (struct sockaddr_dl *)(ifm + 1);
#            if (strncmp(&sdl->sdl_data[0], device, sdl->sdl_nlen) == 0)
#            {   
#                if (!(ea = malloc(sizeof(struct ether_addr))))
#                {
#                    return (NULL);
#                }
#                memcpy(ea->ether_addr_octet, LLADDR(sdl), ETHER_ADDR_LEN);
#                break;
#            }
#        }
#    }
#    free(buf);
#    return (ea);


# automagic functions
sub open {
  my ($self) = @_;
  my $tmp = "open_$self->{filter}";
  return ($self->$tmp());
}
sub write {
  my ($self, %args) = @_;
  my $tmp = "write_$self->{filter}";
  return ($self->$tmp(%args));
}
sub close {
  my ($self) = @_;
  my $tmp = "close_$self->{filter}";
  return ($self->$tmp());
}


1;
__END__

=head1 NAME

Packet::Inject - portably inject raw Ethernet and IP packets

=head1 SYNOPSIS

  use Packet::Inject;

  $i = Packet::Inject->new(
     device => 'eth0',
     filter => 'bpf'
  );
  $i->open();

  my $bytes = $i->write(
     packet => $raw_pkt,
     length => 28,
     times  => 1,
  );
  $i->write(packet => $new_pkt);

  $i->close();

  print "total bytes sent: $bytes\n";

  print "packet dump:\n" . $i->hexdump($raw_ip) . "\n";

=head1 DESCRIPTION

Packet::Inject is a portable, *all Perl* module for injecting raw Ethernet and IP packets.

=head1 FILTERS

Packet::Inject supports:
 BPF		(Berkeley Packet Filter) for *BSD, some Linux & Solaris systems, Darwin,
 SOCK_PACKET	for Linux,
 NIT		(Network Interface Tap) for SunOS 3,
 SNIT		(STREAMS Network Interface Tap) for SunOS 4

Filters to come:
 DLPI		(Data Link Provider Interface) for Solaris, HP-UX, and SCO Openserver,
 PF		(Packet Filter) for Tru64 UNIX,
 SNOOP		for IRIX,
 LSF		(Linux Socket Filter) for Linux kernels 2.1.75 and up

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm
Packet/Sniff.pm

=cut

