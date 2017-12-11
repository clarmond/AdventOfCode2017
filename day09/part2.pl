use strict;
use Test::Simple tests => 12;

ok (&toss_garbage('<><random characters><<<<><{!>}><!!><!!!>><{o"i!a,<{i<a>') eq "");
ok (&toss_garbage('{{<a>},{<a>},{<a>},{<a>}}') eq "{{},{},{},{}}");
ok (&toss_garbage('{{<!>},{<!>},{<!>},{<a>}}') eq "{{}}");

my @test_cases = (
    {
        input => '{}',
        score => 1
    },
    {
        input => '{{{}}}',
        score => 6
    },
    {
        input => '{{},{}}',
        score => 5
    },
    {
        input => '{{{},{},{{}}}}',
        score => 16
    },
    {
        input => '{<a>,<a>,<a>,<a>}',
        score => 1
    },
    {
        input => '{{<ab>},{<ab>},{<ab>},{<ab>}}',
        score => 9
    },
    {
        input => '{{<!!>},{<!!>},{<!!>},{<!!>}}',
        score => 9
    },
    {
        input => '{{<a!>},{<a!>},{<a!>},{<ab>}}',
        score => 3
    },
    {
        input => '{}{{{}}}{{},{}}',
        score => 12
    }    
);

print "Running tests\n";
for (my $i = 0; $i <= $#test_cases; $i++) {
	my $case_number = $i + 1;
	my %data = %{$test_cases[$i]};
    print "Case $case_number: $data{'input'}\n";
	my $actual = &get_score(&toss_garbage($data{"input"}));
	my $expected = $data{"score"};
	ok( $actual == $expected, "Test Case $case_number" );
}

open (IN, "input.txt");
my $puzzle_str = "";
while (<IN>) {
    chomp;
    $puzzle_str .= $_;
}

my $total_garbage_chars = 0;
print "\nPuzzle Score: " . &get_score(&toss_garbage($puzzle_str)) . "\n";
print "Total garbage characters: $total_garbage_chars\n";

sub get_score {
    my ($str) = @_;
    
    my @data = split("", $str);
    my $level = 0;
    my $score = 0;
    for (my $i = 0; $i <= $#data; $i++) {
        my $curr_char = $data[$i];
        if ($curr_char eq "{") {
            $level++;
        }
        if ($curr_char eq "}") {
            $score += $level;
            $level--;
        }
        #print "$i $curr_char $level\n";
    }
    return $score;
}

sub toss_garbage {
    my ($str) = @_;
    
    my @data = split("", $str);
    my $new_str;
    my $in_garbage = 0;
    for (my $i = 0; $i <= $#data; $i++) {
        my $curr_char = $data[$i];
        next if $curr_char eq "";
        if ($curr_char eq "!") {
            $data[$i+1] = "";
            next;
        }
        if (($curr_char eq "<") && (!$in_garbage)) {
            $in_garbage = 1;
            next;
        }
        if ($curr_char eq ">") {
            $in_garbage = 0;
            next;
        }
        if ($in_garbage) {
            $total_garbage_chars++;
        }
        else {
            $new_str .= $curr_char;
        }
    }
    return $new_str;
}

