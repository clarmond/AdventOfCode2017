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

my $continue = 1;
my @letters;
while ($continue) {
	print "Current Position: $x,$y\n";
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
	print "Next Position: $x,$y\n";
	print "Next Char: $next_char\n";
	if ($next_char =~ /[A-Z]/i) {
		push @letters, $next_char;
	}
	if ($next_char eq "+") {
		my %neighbor;
		if ($direction eq "S") {
			$neighbor{"N"} = "";
			$direction = "";
		}
		else {
			$neighbor{"N"} = $table[$x][$y-1];
			$direction = "";
		}
		if ($direction eq "W") {
			$neighbor{"E"} = "";
			$direction = "";
		}
		else {
			$neighbor{"E"} = $table[$x+1][$y];
			$direction = "";
		}
		if ($direction eq "N") {
			$neighbor{"S"} = "";
			$direction = "";
		}
		else {
			$neighbor{"S"} = $table[$x][$y+1];
			$direction = "";
		}
		if ($direction eq "E") {
			$neighbor{"W"} = "";
			$direction = "";
		}
		else {
			$neighbor{"W"} = $table[$x-1][$y];
			$direction = "";
		}
		foreach my $new_dir (keys %neighbor) {
			if ($neighbor{$new_dir}) {
				print "Direction changed to $new_dir\n";
				$direction = $new_dir;
				last;
			}
		}
	}

	last if (($x < 0) || ($y < 0));
	$continue++;
	last if $continue > 100;
}

print "Letters seen: ";
foreach (@letters) {
	print "$_"
}
print "\n";
