#!/usr/bin/perl

use Data::Dumper;
use strict;

my $test_input = <<END;
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
END

#--- Test run
my %nodes = &parse_input($test_input);
my %traversed;
&find_links(0);
my $count = keys %traversed;
print "$count items traversed\n";

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

	print "Traversring $index\n";
	$traversed{$index} = 1;

	my @array = @{$nodes{$index}};
	foreach my $id (@array) {
		&find_links($id);
	}
}
