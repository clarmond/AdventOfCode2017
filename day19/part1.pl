#!/usr/bin/perl

use strict;

my $input_file = $ARGV[0];
die "Input file required\n" unless $input_file;
die "Input file '$input_file' not found\n" unless -e $input_file;

my @table;
open(IN, $input_file);
my $row = 0;
my $starting_x;
while (<IN>) {
	chomp;
	my $line = $_;
	my $length = length($line);
	for (my $col = 0; $col < $length; $col++) {
		my $curr_char = substr($line, $col, 1);
		$curr_char =~ s/ //;
		$table[$col][$row] = $curr_char;
		if ((!$starting_x) && ($curr_char eq "|")) {
			$starting_x = $col;
		}
	}
	$row++;
}

my $direction = "S";
my $x = $starting_x;
my $y = 0;

my @letters;
my @visited;
while (1) {
	#print "Current Position: $x,$y\n";
	if ($direction eq "N") {
		$y--;
	}
	elsif ($direction eq "E") {
		$x++;
	}
	elsif ($direction eq "S") {
		$y++;
	}
	elsif ($direction eq "W") {
		$x--;
	}
	my $next_char = $table[$x][$y];
	$visited[$x][$y] = 1;
	#print "Next Position: $x,$y\n";
	#print "Next Char: $next_char\n";
	if ($next_char =~ /[A-Z]/i) {
		push @letters, $next_char;
	}
	if ($next_char eq "+") {
		my %neighbor;
		$neighbor{"N"} = $table[$x][$y-1] unless $visited[$x][$y-1];
		$neighbor{"E"} = $table[$x+1][$y] unless $visited[$x+1][$y];
		$neighbor{"S"} = $table[$x][$y+1] unless $visited[$x][$y+1];
		$neighbor{"W"} = $table[$x-1][$y] unless $visited[$x-1][$y];
		foreach my $new_dir (keys %neighbor) {
			if ($neighbor{$new_dir}) {
				print "Direction changed to $new_dir\n";
				$direction = $new_dir;
				last;
			}
		}
	}

	last if (($x < 0) || ($y < 0));
}

print "Letters seen: ";
foreach (@letters) {
	print "$_"
}
print "\n";
