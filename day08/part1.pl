#!/usr/bin/perl

my $test_data = <<END;
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
END

&process_code($test_data);

my $data;
open (IN, "input.txt");
while (<IN>) {
    $data .= $_;
}
close IN;
&process_code($data);

sub process_code {
    my ($data) = @_;
    
    my @lines = split(/\n/, $data);
    
    my %register;
    my $highest_value = 0;
    foreach my $line (@lines) {
        if ($line =~ /(\w+) (\w+) ([\d\-]+) if (\w+) ([\!\<\>\=]+) ([\d\-]+)/) {
            my $reg = $1;
            my $op = $2;
            my $delta = $3;
            my $check_reg = $4;
            my $check_op = $5;
            my $check_val = $6;
            if (!(defined $register{$reg})) {
                $register{$reg} = 0;
            }
            if (!(defined $register{$check_reg})) {
                $register{$check_reg} = 0;
            }
            if ($op eq "dec") {
                $delta = $delta * -1;
            }
            my $evaluate = 0;
            if ($check_op eq "<") {
                $evaluate = 1 if ($register{$check_reg} < $check_val);
            }
            if ($check_op eq ">") {
                $evaluate = 1 if ($register{$check_reg} > $check_val);
            }
            if ($check_op eq "<=") {
                $evaluate = 1 if ($register{$check_reg} <= $check_val);
            }
            if ($check_op eq ">=") {
                $evaluate = 1 if ($register{$check_reg} >= $check_val);
            }
            if ($check_op eq "==") {
                $evaluate = 1 if ($register{$check_reg} == $check_val);
            }
            if ($check_op eq "!=") {
                $evaluate = 1 if (!($register{$check_reg} == $check_val));
            }
            if ($evaluate) {
                $register{$reg} += $delta;
                print "$reg += $delta\n";
                print "$reg = $register{$reg}\n";
                if ($register{$reg} > $highest_value) {
                    $highest_value = $register{$reg};
                }
            }
        }
        else {
            die "Exception: $line\n";
        }
        
    }
    
    my $max_value = 0;
    my $max_reg = "";
    foreach my $reg (keys %register) {
        if ($register{$reg} > $max_value) {
            $max_value = $register{$reg};
            $max_reg = $reg;
        }
    }
    
    print "Max register is *$max_reg* with a value of *$max_value*\n";
    print "Highest value was *$highest_value*\n";
}