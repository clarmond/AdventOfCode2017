#!/usr/bin/perl

use Data::Dumper;
use strict;

#--- Run test
my $test_data = <<END;
0: 3
1: 2
4: 4
6: 4
END

my $severity = &run_data($test_data, 1);
print "Severity = $severity\n";

#--- Run puzzle
my $puzzle;
open (IN, "input.txt");
while (<IN>) {
	$puzzle .= $_;
}
close (IN);

my $severity = &run_data($puzzle, 1);
print "Severity = $severity\n";

sub run_data {
	my ($data, $verbose) = @_;

	#--- Intialize scanners
	my %layer_range;
	my %scanner_position;
	my %layer_delta;
	my $max_depth = 0;
	my $max_range = 0;
	foreach my $line (split(/\n/, $data)) {
		$line =~ /(\d+): (\d+)/;
		my $depth = $1;
		my $range = $2;
		$layer_range{$depth} = $range;
		$layer_delta{$depth} = 1;
		$scanner_position{$depth} = 1;
		if ($depth > $max_depth) {
			$max_depth = $depth;
		}
		if ($range > $max_range) {
			$max_range = $range;
		}
	}

	my $severity = 0;

	for (my $pos = 0; $pos <= $max_depth; $pos++) {

		for (my $i = 0; $i <= $max_depth; $i++) {
			print " $i  ";
		}
		print "\n";
		for (my $r = 1; $r <= $max_range; $r++) {
			for (my $i = 0; $i <= $max_depth; $i++) {
				if (($layer_range{$i}) && ($r <= $layer_range{$i})) {
					if (($pos == $i) && ($r == 1)) {
						print "(";
					}
					else {
						print "[";
					}
					if ($scanner_position{$i} == $r) {
						if (($pos == $i) &&  ($scanner_position{$i} == 1)){
							print "X";
							$severity = $severity + ($i * $layer_range{$i})
						}
						else {
							print "S";
						}
					}
					else {
						print " ";
					}
					if (($pos == $i) && ($r == 1)) {
						print ") ";
					}
					else {
						print "] ";
					}
				}
				else {
					if ($r == 1) {
						if (($pos == $i) && ($r == 1)) {
							print "(.) ";
						}
						else {
							print "... ";
						}
					}
					else {
						print "    ";
					}
				}
			}
			print "\n";
		}
		print "\n\n";

		#--- Increment scanner positions
		foreach my $depth (sort keys %scanner_position) {
			$scanner_position{$depth} = $scanner_position{$depth} + $layer_delta{$depth};
			if ($scanner_position{$depth} == $layer_range{$depth}) {
				$layer_delta{$depth} = $layer_delta{$depth} * -1;
			}
			if ($scanner_position{$depth} == 1) {
				$layer_delta{$depth} = $layer_delta{$depth} * -1;
			}
		}
	}

	return $severity;
}
