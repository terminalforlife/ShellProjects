#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/benchmark.sh
# Started On        - Fri  7 Jan 21:16:56 GMT 2022
# Last Change       - Fri  7 Jan 21:34:14 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Benchmark a non-interactive command. Any commands requiring interaction via
# the likes of a prompt won't work with this script. You'll have the average
# runtime (realtime, based on the `time` keyword in BASH).
#
# Exit statuses:
#
#   1 = General script error.
#   2 = AWK detected invalid lines in temporary file.
#   4 = Incorrect number of arguments given to script.
#
# If you given an invalid command, you may not know, so choose carefully. If
# you always see 0.000 for the average, then it could indicate this issue.
#
# Usage: benchmark.sh INT COMMAND
#------------------------------------------------------------------------------

(( $# < 2 )) && exit 4;

TempFile=`mktemp -q --suffix='_average.log'`

Times=$1
shift

(
	TIMEFORMAT='%3R'
	exec &> "$TempFile"
	while (( Iter++ < Times )); do
		time "$@" &> /dev/null
	done
)

awk '
	{
		if ($0 ~ /^[0-9]+\.[0-9]{3}$/) {
			Result += $1
		} else {
			exit(2)
		}
	}

	END {
		printf("[I]terations = %d\n", NR);
		printf("[T]otal = %.3fs\n", Result);
		printf("T / I = %.3fs\n", Result / NR)
	}
' "$TempFile"
rm "$TempFile"
