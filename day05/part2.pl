#!/usr/bin/perl

use strict;

my @lines;
$lines[0] = "";

open (IN, "input.txt");
while (<IN>) {
	chomp $_;
	push @lines, $_;
}

my $last_line = $#lines;
print $last_line . " lines of code\n";

my $curr_line = 1;
my $steps = 0;
while (1) {
	my $offset = $lines[$curr_line];
	my $next_line = $curr_line + $offset;
	print "offset = $offset\n";
	print "curr_line = $curr_line\n";
	print "next_line = $next_line\n";
	print "\n";
	if ($offset >= 3) {
		$lines[$curr_line]--;
	}
	else {
		$lines[$curr_line]++;
	}
	$curr_line = $next_line;
	$steps++;
	if ($curr_line > $last_line) {
		print "Found exit!\n";
		print "Took " . $steps . " steps.\n";
		print "Values are ";
		for (my $i = 1; $i <= $#lines; $i++){
			print "$lines[$i] ";
		}
		print "\n";
		last;
	}
}
