#!/usr/bin/perl

use strict;

#--- Set up test data
my @test_data = (0,1,2,3,4);
my $test_input = "3,4,1,5";

#--- Set up puzzle data
my $puzzle_input = "88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205";
my @puzzle_data;
for (my $i = 0; $i <= 255; $i++) {
	$puzzle_data[$i] = $i;
}

#--- Run test
my $curr_pos = 0;
my $skip_size = 0;
my @test_input_array = split(",", $test_input);
for (my $i = 0; $i <= $#test_input_array; $i++) {
	@test_data = &twist(\@test_data, $test_input_array[$i]);
}
my $results = $test_data[0] * $test_data[1];
print "Results: $results\n\n\n";

#--- Run puzzle
my $curr_pos = 0;
my $skip_size = 0;
my @puzzle_input_array = split(",", $puzzle_input);
for (my $i = 0; $i <= $#puzzle_input_array; $i++) {
	@puzzle_data = &twist(\@puzzle_data, $puzzle_input_array[$i]);
}
my $results = $puzzle_data[0] * $puzzle_data[1];
print "Results: $results\n\n\n";


sub get_list_length {
	my ($str) = @_;
	return (length($str) + 1) / 2;
}

sub twist {
	my @data = @{$_[0]};
	my $input = $_[1];
	#-- Print starting list
	print "\n";
	print "Current position: $curr_pos\n";
	print "    Current skip: $skip_size\n";
	print " Current length : $input\n";
	print "  Current string: ";
	&print_string(\@data);
	my @reversed_data;
	my $reversed_index = $input - 1;
	for (my $i = $curr_pos; $i < $curr_pos + $input; $i++) {
		my $j = $i;
		while ($j > $#data) {
			$j = $j - $#data - 1;
		}
		$reversed_data[$reversed_index] = $data[$j];
		$reversed_index--;
	}
	print " Reversed string: " . join(" ", @reversed_data) . "\n";
	my $index = 0;
	for (my $i = $curr_pos; $i < $curr_pos + $input; $i++) {
		my $j = $i;
		while ($j > $#data) {
			$j = $j - $#data - 1;
		}
		$data[$j] = $reversed_data[$index];
		$index++;
	}
	print "      New string: ";
	&print_string(\@data);
	print "\n";
	$curr_pos = $curr_pos + $input + $skip_size;
	$skip_size++;

	while ($curr_pos > $#data) {
		$curr_pos = $curr_pos - $#data - 1;
	}

	my $check = <STDIN>;

	return @data;
}

sub print_string {
	my @data = @{$_[0]};
	for (my $i = 0; $i <= $#data; $i++) {
		print "[" if $i == $curr_pos;
		print $data[$i];
		print "]" if $i == $curr_pos;
		print " ";
	}
	print "\n";

}
