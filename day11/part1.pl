#!/usr/bin/perl

use strict;
use Test::Simple tests => 4;

my @test_cases = (
	{
		moves => 'ne,ne,ne',
		steps => 3
	},
	{
		moves => 'ne,ne,sw,sw',
		steps => 0
	},
	{
		moves => 'ne,ne,s,s',
		steps => 2
	},
	{
		moves => 'se,sw,se,sw,sw',
		steps => 3
	}
);

print "Running tests\n";
for (my $i = 0; $i <= $#test_cases; $i++) {
	my $case_number = $i + 1;
	my %data = %{$test_cases[$i]};
	my $moves = $data{"moves"};
	print "Case $case_number: $moves\n";
	my $move_count = &calc_steps($moves);
	my $expected = $data{"steps"};
	ok($move_count == $expected, "Test Case $case_number\nExpected=$expected\nActual=$move_count");
}

my $puzzle;
open (IN, "input.txt");
while (<IN>) {
	chomp;
	$puzzle .= $_;
}
close (IN);
print "\nPuzzle moves: " . calc_steps($puzzle) . "\n";

sub calc_steps {
	my ($moves) = @_;

	my $x = 0;
	my $y = 0;

	foreach my $move (split(",", $moves)) {
		if ($move eq "n") {
			$y--;
		}
		elsif ($move eq "s") {
			$y++;
		}
		elsif ($move eq "ne") {
			$x = $x + .5;
			$y = $y - .5;
		}
		elsif ($move eq "se") {
			$x = $x + .5;
			$y = $y + .5;
		}
		elsif ($move eq "sw") {
			$x = $x - .5;
			$y = $y + .5;
		}
		elsif ($move eq "nw") {
			$x = $x - .5;
			$y = $y - .5;
		}
		else {
			die "Invalid move '$move'\n";
		}
	}

	my $total_steps = abs($x) + abs($y);
	print "X,Y = $x,$y\n";
	print "Total steps = $total_steps\n";
	print "\n";
	return $total_steps;
}
