#!/usr/bin/perl

use strict;

my $data = "4	1	15	12	0	9	9	5	5	8	7	3	14	5	12	3";
#$data = "0 2 7 0";
my @banks = split(/\s+/, $data);
my %states;
my $save_state;

my $inital_repeat = 0;
my $count = 0;
while (1 == 1) {
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
	print "$current_state $save_state\n";
	if ($current_state eq $save_state) {
		last;
	}
	if ($states{$current_state}){
		if (!$inital_repeat) {

			$inital_repeat = $count;
		}
		if (!$save_state) {
			$save_state = $current_state;
		}
	}
	else {
		$states{$current_state} = 1;
	}
}

my $cycles = $count - $inital_repeat;
print "$inital_repeat iterations before infinite loop\n";
print "$cycles iterations before repeat\n";

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
