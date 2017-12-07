#!/usr/bin/perl

use strict;
use Test::Simple tests => 5;

my @test_cases = (
	{
		input => "1212",
		result => 6
	},
	{
		input => "1221",
		result => 0
	},
	{
		input => "123425",
		result => 4
	},
	{
		input => "123123",
		result => 12
	},
	{
		input => "12131415",
		result => 4
	}
);

print "Running tests\n";
for (my $i = 0; $i <= $#test_cases; $i++) {
	my $case_number = $i + 1;
	my %data = %{$test_cases[$i]};
	my $actual = &get_total($data{"input"});
	my $expected = $data{"result"};
	ok( $actual == $expected, "Test Case $case_number" );
}

my $puzzle_str;
open (IN, "input.txt");
$puzzle_str = <IN>;
chomp $puzzle_str;
close (IN);

print "\nPuzzle answer: " . &get_total($puzzle_str) . "\n";

sub get_total {
	my ($str) = @_;
	my $total = 0;
	my $str_len = length($str);
	my $offset = $str_len / 2;

	for (my $i = 0; $i < $str_len; $i++) {
		my $j = $i + $offset;
		if ($j > ($str_len - 1)) {
			$j = $j - $str_len;
		}
		my  $curr_char = int(substr($str, $i, 1));
		my  $next_char = int(substr($str, $j, 1));
		if ($curr_char == $next_char) {
			$total += $curr_char;
		}
	}

	return $total;
}
