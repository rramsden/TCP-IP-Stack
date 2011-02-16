package Packet::Sniff;
#
# $Id: Sniff.pm,v 1.2 2002/05/02 21:12:37 cp5 Exp $

use strict;
use Packet::Definitions;
   
use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';
  
use Packet;
@ISA = qw/ Packet /;

sub new {
  my ($class, %args) = @_;
  my $self = {
   filter       => 'bpf', # have to add function to find a filter automagically
   device       => '',    # have to add function to find a device automagically
   %args
  };

  return bless $self, ref($class) || $class;
}

sub open_bpf {
  my ($self) = @_;

  unless (opendir(DEV, "/dev")) {
    $self->{errbuf} = "opendir: /dev: $!\n";
    return 0;
  }
  my @bpf = grep { /^bpf/ } readdir(DEV);
  closedir(DEV);
  foreach (sort(@bpf)) {
    open($self->{fd}, "</dev/$_") && last;
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

  my $undef;
  ioctl($self->{fd}, &Packet::Definitions::BIOCPROMISC, $undef);

  my $size;
  unless (ioctl($self->{fd}, &Packet::Definitions::BIOCGBLEN, $size)) {
    $self->{errbuf} = "BIOCGBLEN: $!\n";
    close($self->{fd});
    return 0;
  }
  $self->{buflen} = unpack("l", $size);

  return 1;
}

sub loop_bpf {
  my ($self, $cnt, $callback_fn, $user_data) = @_;
  my $bytes = 0;
  my $i = 0;

  while (1) {
    my ($packet, $len);
    $len = sysread($self->{fd}, $packet, $self->{buflen});
    if ($len > 0) {
      my $ep = 0;
      while ($ep < $len) {
        my $hdr;
        my $bhp          = &Packet::Definitions::unp_bpf_hdr($packet);
        $hdr->{len}      = $bhp->{bh_datalen};
        $hdr->{caplen}   = $bhp->{bh_caplen};
        $hdr->{tv_sec}   = $bhp->{bh_tstamp}{tv_sec};
        $hdr->{tv_usec}  = $bhp->{bh_tstamp}{tv_usec};

        &{$callback_fn}($user_data, $hdr, substr($packet, $bhp->{bh_hdrlen}, $bhp->{bh_caplen}), $self);

        substr($packet, 0, &Packet::Definitions::BPF_WORDALIGN($bhp->{bh_caplen} + $bhp->{bh_hdrlen}), '');
        $ep    += &Packet::Definitions::BPF_WORDALIGN($bhp->{bh_caplen} + $bhp->{bh_hdrlen});
        $bytes += $bhp->{bh_caplen};

        if (++$i == $cnt) {
          return $bytes;
        }
      }
    }
  }
}


# close methods
sub close_bpf {
  my ($self) = @_;
  return (close($self->{fd}));
}


# automagic functions
sub open {
  my ($self) = @_;
  my $tmp = "open_$self->{filter}";
  return ($self->$tmp());
}
sub loop {
  my ($self, @args) = @_;
  my $tmp = "loop_$self->{filter}";
  return ($self->$tmp(@args));
}
sub close {
  my ($self) = @_;
  my $tmp = "close_$self->{filter}";
  return ($self->$tmp());
}


1;
__END__

=head1 NAME

Packet::Sniff - portably sniff raw Ethernet and IP packets

=head1 SYNOPSIS

  use Packet::Sniff;

  $s = Packet::Sniff->new(
     device => 'eth0',
     filter => 'bpf'
  );
  $s->open();

  $s->loop($cnt, \&callback_fn, $user_data);

  sub callback_fn {
    my ($user_data, $hdr, $pkt, $s) = @_;

    print "length of packet:      $hdr->{len}\n";
    print "actual capture length: $hdr->{caplen}\n";
    print "time since epoch:      $hdr->{tv_sec}\n";
    print "milliseconds:          $hdr->{tv_usec}\n";

    print "packet dump:\n" . $s->hexdump($pkt) . "\n";
  }

=head1 DESCRIPTION

Packet::Sniff is a portable, *all Perl* module for sniffing raw Ethernet and IP packets.

=head1 FILTERS

Packet::Sniff supports:
 BPF		(Berkeley Packet Filter) for *BSD, some Linux & Solaris systems, Darwin

Filters to come:
 SOCK_PACKET	for Linux,
 NIT		(Network Interface Tap) for SunOS 3,
 SNIT		(STREAMS Network Interface Tap) for SunOS 4
 DLPI		(Data Link Provider Interface) for Solaris, HP-UX, and SCO Openserver,
 PF		(Packet Filter) for Tru64 UNIX,
 SNOOP		for IRIX,
 LSF		(Linux Socket Filter) for Linux kernels 2.1.75 and up
 wireless	for wireless cards

=head1 AUTHORS

Samy Kamkar	<cp5@LucidX.com>

Todd Caine	<tcaine@eli.net>

=head1 SEE ALSO

Packet.pm
Packet/Inject.pm

=cut

