#!/usr/bin/perl

use strict;

my $data = "4	1	15	12	0	9	9	5	5	8	7	3	14	5	12	3";
#$data = "0 2 7 0";
my @banks = split(/\s+/, $data);
my %states;

my $keep_looping = 1;
my $count = 0;
while ($keep_looping) {
	$count++;
	my $current_index = &findMaxIndex(@banks);
	my $current_state = join(" ", @banks);
	my $max_value = $banks[$current_index];
	$banks[$current_index] = 0;
	for (my $i = $max_value; $i > 0; $i--) {
		$current_index++;
		if ($current_index > $#banks) {
			$current_index = 0;
		}
		$banks[$current_index]++;
	}
	my $current_state = join(" ", @banks);
	print "$current_state\n";
	if ($states{$current_state}) {
		$keep_looping = 0;
	}
	else {
		$states{$current_state} = 1;
	}
}

print "$count iterations before infinite loop\n";

sub findMaxIndex {
	my @values = @_;
	my $max_value = 0;
	my $max_index = 0;
	for (my $i = $#values; $i >= 0; $i--) {
		if ($values[$i] >= $max_value) {
			$max_value = $values[$i];
			$max_index = $i;
		}
	}
	return $max_index;
}
