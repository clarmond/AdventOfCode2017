#!/usr/bin/perl

use Data::Dumper;
use strict;

#--- Puzzle input
my $puzzle_str;
open (IN, "input.txt");
while (<IN>) {
	$puzzle_str .= $_;
}
close (IN);

#--- Test run
my %nodes = &parse_input($puzzle_str);
my %traversed;
my $max_value = 0;
my %groups;
foreach my $node (sort keys %nodes) {
	undef %traversed;
	$max_value = 0;
	&find_links($node);
	my $count = keys %traversed;
	$groups{$max_value} = $node;
	#print "$count items traversed in node $node\n";
	#print "Max value = $max_value\n";
}

my $group_count = keys %groups;
print "Groups: $group_count\n";

sub parse_input {
	my ($input) = @_;

	my %nodes;

	foreach my $line (split(/\n/, $input)) {
		if ($line =~ /(\d+) <-> ([\d\s\,]+)/) {
			my $node = $1;
			my $list = $2;
			$list =~ s/ //g;
			my @list_array = split(",", $list);
			$nodes{$node} = \@list_array;
		}
		else {
			die "Could not process line '$line'\n";
		}
	}

	return %nodes;
}

sub find_links {
	my ($index) = @_;

	return if $traversed{$index};

	#print "Traversring $index\n";
	$traversed{$index} = 1;
	if ($index > $max_value) {
		$max_value = $index;
	}

	my @array = @{$nodes{$index}};
	foreach my $id (@array) {
		&find_links($id);
	}
}
