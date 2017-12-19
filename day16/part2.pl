#!/usr/bin/perl

use strict;

my $input_file = $ARGV[0];
die "Input file required\n" unless $input_file;
die "Input file '$input_file' not found\n" unless -e $input_file;

open(IN, $input_file);
my $program_list = <IN>;
chomp $program_list;
my $move_list = <IN>;
chomp $move_list;
close (IN);

my @programs = split("", $program_list);
my @moves = split(",", $move_list);
my %combinations;
for (my $counter = 1; $counter <= 1000; $counter++) {
	foreach my $move (@moves) {
		if ($move =~ /s(\d+)/) {
			my $count = $1;
			for (my $i = 1; $i <= $count; $i++) {
				my $char = $programs[$i * -1];
				unshift @programs, $char;
			}
			for (my $i = $count; $i > 0; $i--) {
				pop @programs;
			}
		}
		elsif ($move =~ /x(\d+)\/(\d+)/) {
			my $a_pos = $1;
			my $b_pos = $2;
			my $a = $programs[$a_pos];
			my $b = $programs[$b_pos];
			$programs[$a_pos] = $b;
			$programs[$b_pos] = $a;
		}
		elsif ($move =~ /p(\w)\/(\w)/) {
			my $a_val = $1;
			my $b_val = $2;
			my $a_pos;
			my $b_pos;
			for (my $i = 0; $i <= $#programs; $i++) {
				$a_pos = $i if $programs[$i] eq $a_val;
				$b_pos = $i if $programs[$i] eq $b_val;
			}
			my $a = $programs[$a_pos];
			my $b = $programs[$b_pos];
			$programs[$a_pos] = $b;
			$programs[$b_pos] = $a;
		}
		else {
			die "Unknown move: $move\n";
		}
	}
	my $list = join("", @programs);
	if ($combinations{$list}) {
		last;
	}
	else {
		$combinations{$list} = $counter;
	}
}

my @lists;
foreach my $key (keys %combinations) {
	my $value = $combinations{$key};
	$lists[$value] = $key;
}

my $total_combinations = $#lists;
my $index = 1000000000 % $total_combinations;
print $lists[$index] . "\n";
