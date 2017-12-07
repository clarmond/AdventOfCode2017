#!/usr/bin/perl

use strict;
use Test::Simple tests => 1;

#--- Define test data
my $test_data = <<END;
5 1 9 5
7 5 3
2 4 6 8
END
my $actual = &calc_checksum($test_data);
my $expected = 18;

#--- Run test
ok( $actual == $expected, "Test case" );

#--- Read puzzle input
my $puzzle_data;
open (IN, "input.txt");
while (<IN>) {
	$puzzle_data .= $_;
}
close (IN);

#--- Print result
print "Checksum = " . &calc_checksum($puzzle_data) . "\n";

#-------------------------------------------------------------------------------
#  sub: calc_checksum
# desc: Calculates the checksum by taking a difference of the smallest and
#       largest numbers in each line and then summing the results.
#-------------------------------------------------------------------------------
sub calc_checksum {
	my ($input) = @_;

	my $checksum = 0;
	foreach my $line (split(/\n/, $input)) {
		my $min_val;
		my $max_val;
		foreach my $value (split(/\s+/, $line)) {
			if ((!$min_val) || ($value < $min_val)) {
				$min_val = $value;
			}
			if ((!$max_val) || ($value > $max_val)) {
				$max_val = $value;
			}
		}
		my $diff = $max_val - $min_val;
		$checksum += $diff;
	}

	return $checksum;
}
