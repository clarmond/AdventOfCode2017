#!/usr/bin/perl

use strict;

my %children;
my %nodes;
my %parent;
my %weight;

open (IN, "input.txt");
while (<IN>) {
	chomp;
	my $line = $_;
	$line =~ /^(\w+) \((\d+)/;
	my $node = $1;
	$nodes{$node} = 1;
	$weight{$node} = $2;
	if ($line =~ /\-\> (.+)/) {
		my $child_list = $1;
		my @children = split(", ", $child_list);
		$children{$node} = \@children;
		foreach my $child (@children) {
			$parent{$child} = $node;
		}
	}
}

my $bottom_node;
foreach my $node (keys %nodes) {
	next if $parent{$node};
	$bottom_node = $node;
}

my @first_children = @{$children{$bottom_node}};
foreach my $child (@first_children) {
	print "$child:\n";
	my $total_weight = &get_children_weight($child, $weight{$child}, 2);
	print "Total Weight for $child: $total_weight\n\n";
}

exit;

sub get_children_weight {
	my ($node, $total_weight, $indent) = @_;
	print " " x $indent . "Level $indent: $node ($weight{$node})\n";
	if (!(ref $children{$node} eq "ARRAY")) {
		return $weight{$node};
	}
	my @children = @{$children{$node}};
	my $total = $weight{$node};
	foreach my $child (@children) {
		#print " " x $indent . "$child ($weight{$child})\n";
		my $child_weights = &get_children_weight($child, $total_weight, $indent + 2);
		$total += $child_weights;
		#print " " x $indent . "Child Weights: $child_weights\n";
	}
	return $total;
}
