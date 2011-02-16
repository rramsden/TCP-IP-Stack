#!/usr/bin/perl
use threads;
use Class::Struct;


#structure for packets
struct( Packet => {
	data => '$',
	inPacket => '$',
});
	


#make a new packet
$newPacket=Packet->new(data=>"11110000", inPacket=>"f");

#array to be called @Packets and add the new packet to it
push(@Packets,$newPacket);


#threads only take an array of arguments so set up the array of arguments
@args=($Packets[0]);

#create the thread first param is a string for the thread of handlePacket, and the second param is for the array of arguments
$thread = threads->create('handlePacket',@args);


#the function to handle a packet (sample code)
sub handlePacket{
	#get the params
	@params=@_;

	#treat the first element of the array as a packet and print out the fields in it (that you have access to)
	$tmp=$params[0];
	print $tmp->data;
	print "\n";
	print $tmp->inPacket;
	print "\n";
}
