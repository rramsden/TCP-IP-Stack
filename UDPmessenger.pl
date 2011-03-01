#!/usr/bin/perl -w

# UDPmessenger.pl
# Created Feb 28, 2011 - Andrew Walker
# This little gem of a program is for doing UDP testing on our yet-to-exist TCP/IP stack.
# It is using UDP sockets until we have enough functionality in 'NetStack' to do UDP testing.
# There is NO error checking. You break it, you bought it.

# There are 3 commands:
# 1. PORT {port} - set what port you want to listen for messages on
# 2. CONNECT {ip_address/url} {port} - set where to send messages
# 3. UNAME {user_name} - set your display name
# 
# Anything else will be treated as a message.
# Use ^C to exit the program.
#
# ------------ Example Usage ---------------
# Terminal #1:
# ~/csci460/TCP-IP-Stack:./UDPmessenger.pl
# UDP_MESSENGER
# UNAME Walker
# Walker
# PORT 5674
# Walker
# CONNECT localhost 5675
# Walker
# Stalker
# Hey
# Walker
# What?
# Walker
# Stalker
# AAAAAAAAAAAAAHHHHHHHHHHHH!!!!!!!
# Walker
# BLOCKED
# Walker
# ^C
# 
# Terminal #2:
# ~/csci460/TCP-IP-Stack:./UDPmessenger.pl 
# UDP_MESSENGER
# PORT 5675
# UDP_MESSENGER
# CONNECT localhost 5674
# UDP_MESSENGER
# UNAME Stalker
# Stalker
# Hey
# Stalker
# Walker
# What?
# Stalker
# AAAAAAAAAAAAAHHHHHHHHHHHH!!!!!!!
# Stalker
# Walker
# BLOCKED
# Stalker
# ^C



use strict;

use IO::Select;
use IO::Socket;

my $UNAME = 'UDP_MESSENGER';
my $listen; # this will be the socket we listen for messages on
my $message; # this will be the socket we send messages to

# the select related junk
my $sel = new IO::Select();
$sel->add(\*STDIN);
my $fh;
my @ready;

print($UNAME, "\n"); # print the prompt
while(@ready = $sel->can_read) # grab the list of file handles that are ready with goodies
{
	foreach $fh (@ready)
	{
		if($fh == \*STDIN) # thar be data on stdin!
		{
			my $input = <STDIN>;
			my @cmd = split(/\s/, $input); # split on whitespace
			if($cmd[0] eq 'PORT')
			{
				if(defined($listen)) # for the first time PORT is called
				{
					$sel->remove($listen); # stop listening on the old socket
				}
				$listen = new IO::Socket::INET(LocalPort=>$cmd[1],Proto=>'udp') or die("Can't make UDP socket: $@");
				$sel->add($listen); # start listening on new socket
			}
			elsif($cmd[0] eq 'CONNECT')
			{
				$message = new IO::Socket::INET(Proto=>'udp',PeerAddr=>$cmd[1],PeerPort=>$cmd[2]) or die("Can't make UDP socket: $@");
			}
			elsif($cmd[0] eq 'UNAME')
			{
				#set user name
				$UNAME = $cmd[1];
			}
			else
			{
				#send message
				$message->send($UNAME."\n".$input);
			}
		}
		else # thar be data on ye udp socket! yar!
		{
			my ($datagram,$flags);
			$listen->recv($datagram, 1024, $flags); # read up to 1024 bytes from udp socket
			print($datagram);
			# STDOUT->flush();
		}
	}
	print($UNAME, "\n"); # print the prompt
}