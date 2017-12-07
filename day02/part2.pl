#!/usr/bin/perl

use strict;
use Test::Simple tests => 1;

#--- Define test data
my $test_data = <<END;
5 9 2 8
9 4 7 3
3 8 6 5
END
my $actual = &calc_checksum($test_data);
my $expected = 9;

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
# desc: Calculates the checksum using evenly divisible values
#-------------------------------------------------------------------------------
sub calc_checksum() {
	my ($input) = @_;
	my @lines = split(/\n/, $input);
	my $checksum = 0;
	foreach my $line (@lines) {
		my @vals = split(/\s+/, $line);
		for (my $i = 0; $i <= $#vals; $i++) {
			for (my $j = 0; $j <= $#vals; $j++) {
				if (!($i == $j)) {
					my $actual = $vals[$i] / $vals[$j];
					my $rounded = int($actual);
					if ($actual == $rounded) {
						$checksum += $actual;
					}
				}
			}
		}
	}
	return $checksum
}
