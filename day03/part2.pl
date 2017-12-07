#!/usr/bin/perl

use strict;

my $cx = 1000;
my $cy = 1000;

my $x = $cx;
my $y = $cy;

my %cell_by_pos;
my %cell_by_num;

my $curr_dir = "E";

my $min_x = $cx;
my $min_y = $cy;
my $max_x = $cx;
my $max_y = $cy;

$cell_by_pos{$x}{$y} = 1;

my $max_value = 277678;

for (my $i = 2; $i <= $max_value; $i++) {
	if ($curr_dir eq "E") {
		$x++;
		if (!($cell_by_pos{$x}{$y-1})) {
			$curr_dir = "N";
		}
	}
	elsif ($curr_dir eq "N") {
		$y--;
		if (!($cell_by_pos{$x-1}{$y})) {
			$curr_dir = "W";
		}
	}
	elsif ($curr_dir eq "W") {
		$x--;
		if (!($cell_by_pos{$x}{$y+1})) {
			$curr_dir = "S";
		}
	}
	elsif ($curr_dir eq "S") {
		$y++;
		if (!($cell_by_pos{$x+1}{$y})) {
			$curr_dir = "E";
		}
	}
	&set_position($i, $x, $y);
}

for (my $row = $min_y; $row <= $max_y; $row++) {
	for (my $col = $min_x; $col <= $max_x; $col++) {
		if ($cell_by_pos{$col}{$row}) {
			print sprintf("%03d", $cell_by_pos{$col}{$row});
		}
		else {
			print "---";
		}
		print " ";
	}
	print "\n";
}



sub set_position {
	my ($number, $x, $y) = @_;
	my $sum = 0;
	for (my $i = $x - 1; $i <= $x + 1; $i++) {
		for (my $j = $y - 1; $j <= $y + 1; $j++) {
			if (!(($i == $x) && ($j == $y))) {
				$sum += $cell_by_pos{$i}{$j};
			}
		}
	}
	if ($sum > $max_value) {
		die "Puzzle answer is $sum\n";
	}

	$cell_by_num{$sum} = "$x,$y";
	$cell_by_pos{$x}{$y} = $sum;
	if ($x < $min_x) {
		$min_x = $x;
	}
	if ($x > $max_x) {
		$max_x = $x;
	}
	if ($y < $min_y) {
		$min_y = $y;
	}
	if ($y > $max_y) {
		$max_y = $y;
	}
}
