#!/usr/bin/env perl

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/source/simplify-ubuntu/dev/qrand.pl
# Started On        - Mon  1 Feb 00:12:40 GMT 2021
# Last Change       - Wed  2 Aug 23:42:33 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Developer script for in-place editing of the provided file, changing all
# instances of a question number with a random integer; basically, assigning
# a random, unique 4-digit number to each question.
#
# This should really only be executed once, but keeping it around in-case it's
# needed after the fact.
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

my (@Lines, @Randoms);
if (open(my $FH, '+<', $ARGV[0])) {
	while (<$FH>) {
		if (/.*\"(\[[0-9]+\]: .*)\"/) {
			my ($NumField, @Junk) = split(' ', $1);

			my $Random;
			while (1) {
				$Random = sprintf('%#.4d', int(rand(9999)));
				grep({$_ eq $Random} @Randoms) or last
			}

			push(@Lines, $_ =~ s/\Q$NumField\E/[$Random]:/dr)
		} else {
			push(@Lines, $_)
		}
	}

	truncate($FH, 0);
	seek($FH, 0, 0);
	map(print($FH $_), @Lines);

	close($FH)
}
