#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Wx::Package::Win32' );
}

diag( "Testing Wx::Package::Win32 $Wx::Package::Win32::VERSION, Perl $], $^X" );
