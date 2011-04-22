package Packet;
#
# $Id: Packet.pm,v 1.10 2002/05/14 02:54:31 tcaine Exp $

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

sub new    { die "new() is a virtual method\n"    }
sub encode { die "encode() is a virtual method\n" }
sub decode { die "decode() is a virtual method\n" }

sub checksum {
  my ($msg, $src_ip, $dest_ip) = @_;
  my $tot = 0;
  my $tmp;
  while ($tmp = unpack('n', substr($msg, 0, 2, ''))) {
    $tot += $tmp;
  }
  
  
  
  my $back = pack('n', $tot % 65535);
  return(~$back);
}

# taken from Convert::BER and modified very slightly;)
sub hexdump ($;$) {
  my ($self, $bindata) = @_;
  my $pos     = 0;
  my $output  = '';
  my $fmt     = length($bindata) > 0xffff ? "%08X" : "%04X";  $fmt .= " : ";
  my $offset  = 0;
  my $cnt     = 1 << 4;
  my $len     = length($bindata);
  my $linefmt = ("%02X " x $cnt) . "%s\n";
  $bindata    = $self->encode unless $bindata;

  while ($offset < $len) {
    my $data = substr($bindata,$offset,$cnt);
    my @y = unpack("C*",$data);

    $output .= sprintf $fmt, $pos if $fmt;

    # On the last time through replace '%02X ' with '__ ' for the
    # missing values
    substr($linefmt, 5*@y,5*($cnt-@y)) = "   " x ($cnt-@y)
        if @y != $cnt;

    # Change non-printable chars to '.'
    $data =~ s/[\x00-\x1f\x7f-\xff]/./sg;
    $output .= sprintf $linefmt, @y,$data;

    $offset += $cnt;
    $pos += $cnt;
  }
  return $output;
}

1;
__END__

=head1 NAME

Packet - Perl extensions for encoding, decoding, injecting and sniffing network packets

=head1 SYNOPSIS

  don't 'use Packet;' directly yet!

=head1 DESCRIPTION

Packet is a suite of portable Perl modules for encoding, decoding,
injecting and sniffing low-level network packets.  Packet also
provides functionality for other low-level network tasks such as
retrieving network device information and working directly with
ARP cache tables.

=head1 AUTHORS

Samy Kamkar     <cp5@LucidX.com>

Todd Caine      <tcaine@eli.net>

=head1 SEE ALSO

perl(1)

=cut
