#!/usr/bin/awk -f

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/devutils/convertvars.awk
# Started On        - Wed 27 Nov 16:51:42 GMT 2019
# Last Change       - Wed 19 Jan 14:16:11 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Developer tool I'm sharing in-case somebody has a similar problem to which
# they need a solution, one of which he or she perhaps found here.
#
# Compile a unique, sigil-omitted list of uppercase-only variable names, -
# intended to be used one file at a time, at least for now.
#
# Usage: convertvars.sh [FILE]
#------------------------------------------------------------------------------

{
	for (F = 0; F < NF; F++) {
		if ($F ~ /^\$[A-Z_]+$/) {
			A[$F]++
		}
	}
}

END {
	for (I in A) {
		X=substr(I, 2, length(I))
		printf("%s\n", X)
	}
}
