#!/usr/bin/perl

use Test::Simple tests => 5;

#--- Define tests
my @test_cases = (
	{
		input => "abcde fghij",
		valid => 1
	},
	{
		input => "abcde xyz ecdab",
		valid => 0
	},
	{
		input => "a ab abc abd abf abj",
		valid => 1
	},
	{
		input => "iiii oiii ooii oooi oooo",
		valid => 1
	},
	{
		input => "oiii ioii iioi iiio",
		valid => 0
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
		$valid_count ++;
	}
}

print "$valid_count valid lines\n";

#-------------------------------------------------------------------------------
#  sub: is_line_valid
# desc: Determines if a line is valid (has no anagrams)
#-------------------------------------------------------------------------------
sub is_line_valid {
	my ($line) = @_;

	my @words = split(" ", $line);
	my $valid_line = 1;
	for (my $i = 0; $i <= $#words; $i++) {
		for (my $j = 0; $j <= $#words; $j++) {
			if ($i != $j) {
				my @word1 = split("", $words[$i]);
				my @word2 = split("", $words[$j]);
				if ($#word1 == $#word2) {
					my @sorted1 = sort @word1;
					my @sorted2 = sort @word2;
					my $identical = 1;
					for (my $x = 0; $x <= $#sorted1; $x++) {
						if (!($sorted1[$x] eq $sorted2[$x])) {
							$identical = 0;
							last;
						}
					}
					if ($identical) {
						#print "$words[$i] is an anagram for $words[$j]\n";
						$valid_line = 0;
					}
				}
			}
		}
	}

	return $valid_line;
}
