#!/usr/bin/perl

use strict;
use Test::Simple tests => 3;

#--- Define tests
my @test_cases = (
	{
		input => "aa bb cc dd ee",
		valid => 1
	},
	{
		input => "aa bb cc dd aa",
		valid => 0
	},
	{
		input => "aa bb cc dd aaa",
		valid => 1
	}
);

#--- Run tests
print "Running tests\n";
for (my $i = 0; $i <= $#test_cases; $i++) {
	my $case_number = $i + 1;
	my %data = %{$test_cases[$i]};
	my $actual = &is_line_valid($data{"input"});
	my $expected = $data{"valid"};
	ok( $actual == $expected, "Test Case $case_number" );
}

#--- Read input and process
open (IN, "input.txt");
my $valid_count = 0;
while (<IN>) {
	my $line = $_;
	chomp $line;
	if (&is_line_valid($line)) {
		$valid_count++;
	}
}

print "$valid_count valid lines\n";

#-------------------------------------------------------------------------------
#  sub: is_line_valid
# desc: Determines if a line is valid (has no duplicates)
#-------------------------------------------------------------------------------
sub is_line_valid {
	my ($line) = @_;
	my %words;
	foreach my $word (split(" ", $line)) {
		$words{$word}++;
	}
	my $is_valid = 1;
	foreach my $key (keys %words) {
		if ($words{$key} > 1) {
			$is_valid = 0;
		}
	}
	return $is_valid;
}
