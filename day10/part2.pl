#!/usr/bin/perl

use Data::Dumper;
use strict;

my $verbose = 0;

#--- Set up puzzle data
my @puzzle_data;
for (my $i = 0; $i <= 255; $i++) {
	$puzzle_data[$i] = $i;
}
my $puzzle_input = "88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205";
my @puzzle_input_array = &convert_to_ascii($puzzle_input);
push @puzzle_input_array, 17;
push @puzzle_input_array, 31;
push @puzzle_input_array, 73;
push @puzzle_input_array, 47;
push @puzzle_input_array, 23;

#--- Run puzzle (64 times)
my $curr_pos = 0;
my $skip_size = 0;
for (my $loop = 1; $loop <= 64; $loop++) {
	for (my $i = 0; $i <= $#puzzle_input_array; $i++) {
		@puzzle_data = &twist(\@puzzle_data, $puzzle_input_array[$i]);
	}
}

#--- Reduce
my @blocks;
for (my $block = 0; $block < 16; $block++) {
	my $offset = $block * 16;
	my $curr_value = $puzzle_data[$offset];
	for (my $i = 1; $i < 16; $i++) {
		my $j = $i + $offset;
		$curr_value = $curr_value ^ $puzzle_data[$j];
	}
	push @blocks, $curr_value;
}

#--- Calculate hexidecimal hash
my $hash = "";
foreach my $block (@blocks) {
	$hash .= sprintf("%0x", $block);
}
print "$hash\n";


sub get_list_length {
	my ($str) = @_;
	return (length($str) + 1) / 2;
}

sub twist {
	my @data = @{$_[0]};
	my $input = $_[1];
	#-- Print starting list
	if ($verbose) {
		print "\n";
		print "Current position: $curr_pos\n";
		print "    Current skip: $skip_size\n";
		print " Current length : $input\n";
		print "  Current string: ";
	}
	&print_string(\@data) if $verbose;
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
	print " Reversed string: " . join(" ", @reversed_data) . "\n" if $verbose;
	my $index = 0;
	for (my $i = $curr_pos; $i < $curr_pos + $input; $i++) {
		my $j = $i;
		while ($j > $#data) {
			$j = $j - $#data - 1;
		}
		$data[$j] = $reversed_data[$index];
		$index++;
	}
	if ($verbose) {
		print "      New string: ";
		&print_string(\@data);
		print "\n";
	}
	$curr_pos = $curr_pos + $input + $skip_size;
	$skip_size++;

	while ($curr_pos > $#data) {
		$curr_pos = $curr_pos - $#data - 1;
	}

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

sub convert_to_ascii {
	my ($input) = @_;

	my @data = split("", $input);

	for (my $i = 0; $i <= $#data; $i++) {
		my $asc = ord($data[$i]);
		$data[$i] = $asc;
	}

	return @data;
}
