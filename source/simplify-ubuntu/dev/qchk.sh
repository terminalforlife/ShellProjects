#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - Extra/source/simplify-ubuntu/qchk.sh
# Started On        - Mon  1 Feb 00:47:10 GMT 2021
# Last Change       - Thu 16 Dec 00:07:04 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Simple developer script for parsing simplify-ubuntu(8) in order to check that
# each question number is in-fact unique.
#
# Takes one argument, that being the path of simplify-ubuntu(8) to parse.
#------------------------------------------------------------------------------

Err(){
	printf 'Err: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

if [ -z "$1" ]; then
	Err 1 "File path not provided."
elif [ -f "$1" ] && [ -r "$1" ]; then
	Err 1 "File missing or unreadable."
fi

grep '.*"\[[0-9]\+\]: .*"' "$File" |
	sed 's/.*"\[\([0-9]\+\)\]:.*/\1/' | sort | uniq -d
