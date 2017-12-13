#!/usr/bin/perl

use Data::Dumper;
use strict;

#--- Run puzzle
my $puzzle;
open (IN, "input.txt");
while (<IN>) {
	$puzzle .= $_;
}
close (IN);

my $delay = 6000;
my $severity = 1;
while ($severity) {
	$severity = &run_data($puzzle, $delay);
	print "Delay = $delay  Caught = $severity\n";
	if ($severity) {
		$delay++;
	}
}

sub run_data {
	my ($data, $delay) = @_;

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

	for (my $iter = 0; $iter <= $max_depth + $delay; $iter++) {
		my $pos = $iter - $delay;

		for (my $r = 1; $r <= $max_range; $r++) {
			for (my $i = 0; $i <= $max_depth; $i++) {
				if (($layer_range{$i}) && ($r <= $layer_range{$i})) {
					if ($scanner_position{$i} == $r) {
						if (($pos == $i) &&  ($scanner_position{$i} == 1)){
							print "$pos\n";
							return 1;
						}
					}
				}
			}
		}

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

	return 0;
}
