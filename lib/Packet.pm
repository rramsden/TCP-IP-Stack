package Packet;
#
# $Id: Packet.pm,v 1.10 2002/05/14 02:54:31 tcaine Exp $

use strict;

use vars qw/ $VERSION /;
$VERSION = '0.01';

sub new    { die "new() is a virtual method\n"    }
sub encode { die "encode() is a virtual method\n" }
sub decode { die "decode() is a virtual method\n" }

# checksum used for UDP, TCP, and IGMP
sub checksum {
  my ($len, $protocol, $src_ip, $dest_ip, $pkt) = @_;
  my $padding = ($len % 2 == 1); # need to add a byte if size is odd
  my $sum = 0;          
  my $i = 0;       
  
  if ($padding) {
	substr($pkt, $len, 1, pack("C", 0)); # append 0x00
  }

  # make 16 bit words out of every two adjacent 8 bit words and 
  # calculate the sum of all 16 vit words
  for($i = 0; $i < $len + $padding; $i = $i+2) {
    $sum += unpack('n', substr($pkt, 0, 2, ''));
  }

  # sum up 16 bit entries for ip addresses
  for($i = 0; $i < 4; $i = $i+2) {
    $sum += unpack('n', substr($src_ip, 0, 2, ''));
    $sum += unpack('n', substr($dest_ip, 0, 2, ''));
  }

  $sum += ($protocol + $len);
  $sum = (($sum & 0xFFFF) + ($sum >> 16)); # only last 16 bits and add carries
    
  return pack('n', ~$sum); # bitwise-not / one's complement of sum
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
