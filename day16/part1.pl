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
foreach my $move (split(",", $move_list)) {
	&print_list(@programs);
	print "Move: $move\n";
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
	&print_list(@programs);
	print "\n";
}

sub print_list {
	foreach (@_) {
		print $_;
	}
	print "\n";
}
