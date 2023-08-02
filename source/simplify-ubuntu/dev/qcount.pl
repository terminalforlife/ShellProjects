#!/usr/bin/env perl

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/source/simplify-ubuntu/dev/qcount.pl
# Started On        - Sun 31 Jan 22:59:08 GMT 2021
# Last Change       - Wed  2 Aug 23:42:33 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Developer script for parsing simplify-ubuntu(8) in order to display a talley
# of questions it gives, including displaying each question.
#
# Takes one argument, that being the path of simplify-ubuntu(8) to parse.
#------------------------------------------------------------------------------

use strict;
use warnings;
use autodie;

no warnings 'uninitialized';

if (length($ARGV[0]) == 0) {
	die("File path not provided")
} elsif (! -f "$ARGV[0]" and ! -r "$ARGV[0]") {
	die("File '$ARGV[0]' missing or unreadable")
}

my %Questions;
if (open(my $FH, '<', $ARGV[0])) {
	while (<$FH>) {
		chomp();

		if (/.*\"(\[[0-9]+\]: .*)\"/) {
			my $QLine = $1;
			my ($NumField, @String) = split(' ', $QLine);
			my $Number = $NumField =~ tr/0123456789//dcr;

			$Questions{$Number} = join(' ', @String)
		}
	}

	close($FH)
}

my @SortedKeys = sort({$a cmp $b} keys(%Questions));

foreach my $CurQ (@SortedKeys) {
	printf("%d: \"%s\"\n", $CurQ, $Questions{$CurQ});
}

printf("\nSimplify Ubuntu asks %d question(s).\n", scalar(@SortedKeys))
