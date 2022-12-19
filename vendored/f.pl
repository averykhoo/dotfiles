#!/usr/bin/perl

# from: https://blog.plover.com/prog/runN.html

# todo: would be nice to be able to specify a delimiter, and to get a range of fields
# basically cut, but able to start from the middle

my $field = shift or usage();
$field -= 1 if $field > 0;
$|=1;

while (<>) {
    chomp;
    my @f = split;
    print $f[$field], "\n";
}

sub usage {
    print STDERR "$0 fieldnumber\n";
    exit 1;
}