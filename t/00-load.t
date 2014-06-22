#!perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'Alien::AntTweakBar' ) || print "Bail out!\n";
}

diag( "Testing Alien::AntTweakBar $Alien::AntTweakBar::VERSION, Perl $], $^X" );
