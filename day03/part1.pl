#!/usr/bin/perl

use strict;
use Test::Simple tests => 4;

#--- Define tests
my @test_cases = (
	{
		input => 1,
		result => 0
	},
	{
		input => 12,
		result => 3
	},
	{
		input => 23,
		result => 2
	},
	{
		input => 1024,
		result => 31
	},
);

#--- Define center indexes
my $cx = 1000;
my $cy = 1000;

#--- Set starting postion to center
my $x = $cx;
my $y = $cy;

#--- Define hashes to store cell data by position and by number
my %cell_by_pos;
my %cell_by_num;

#--- Start by moving to the right (East)
my $curr_dir = "E";

#--- Initialize minimum values
my $min_x = $cx;
my $min_y = $cy;
my $max_x = $cx;
my $max_y = $cy;

#--- Set 1 to center position
&set_position(1, $x, $y);

#--- Start building the spiral
for (my $i = 2; $i <= 277678; $i++) {
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

#--- Run tests
print "Running tests\n";
for (my $i = 0; $i <= $#test_cases; $i++) {
	my $case_number = $i + 1;
	my %data = %{$test_cases[$i]};
	my $actual = &get_distance($data{"input"});
	my $expected = $data{"result"};
	ok( $actual == $expected, "Test Case $case_number" );
}

print "\nDistance from 277678 to center: " . &get_distance(277678) . "\n";

#-------------------------------------------------------------------------------
#  sub: get_distance
# desc: Calculates distance from given cell to center cell
#-------------------------------------------------------------------------------
sub get_distance() {
	my ($number) = @_;

	my ($x, $y) = split(",", $cell_by_num{$number});
	my $h_dist = abs($x - $cx);
	my $v_dist = abs($y - $cy);
	return $h_dist + $v_dist;
}

#-------------------------------------------------------------------------------
#  sub: set_position
# desc: Sets postion of given number at x and y position
#-------------------------------------------------------------------------------
sub set_position {
	my ($number, $x, $y) = @_;
	$cell_by_num{$number} = "$x,$y";
	$cell_by_pos{$x}{$y} = $number;
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
