use strict;

use lib "lib";

use NetStack;



my $stack = NetStack->new(
    my_ip => '10.0.0.31',
    my_mac => 'aa:aa:bb:bb:cc:cc',
    device => 'tap0',
    netmask => '255.255.255.0',
    default => '10.0.0.30',
    );
$stack->run();
