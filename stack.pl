use strict;

use lib "lib";

use NetStack;



my $stack = NetStack->new(
    my_ip => '10.0.0.16',
    my_mac => 'aa:bb:cc:aa:bb:cc',
    device => 'tap0',
    netmask => '255.255.255.0'
    );
$stack->run();
