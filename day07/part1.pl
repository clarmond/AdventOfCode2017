#!/usr/bin/perl

use strict;

my %nodes;
my %parent;

open (IN, "input.txt");
while (<IN>) {
	chomp;
	my $line = $_;
	$line =~ /^(\w+)/;
	my $node = $1;
	$nodes{$node} = 1;
	if ($line =~ /\-\> (.+)/) {
		my $child_list = $1;
		my @children = split(", ", $child_list);
		foreach my $child (@children) {
			$parent{$child} = $node;
		}
	}
}

foreach my $node (keys %nodes) {
	next if $parent{$node};
	print "Bottom Node: $node\n";
}
