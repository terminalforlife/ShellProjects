#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - Extra/source/fetcher/dev/core.sh
# Started On        - Sun 21 Feb 00:53:31 GMT 2021
# Last Change       - Sun 21 Feb 01:34:07 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Test the core functionality of Fetcher.
#
# Features:
#
# N/A
#
# Bugs:
#
# N/A
#
# Dependencies:
#
#   bash
#   coreutils
#------------------------------------------------------------------------------

Err() {
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

Top=`git rev-parse --show-toplevel`
Exec="$Top/source/fetcher/fetcher"

if ! cd "$Top/source/fetcher"; then
	Err 1 "Unable to change to 'fetcher' directory."
fi

Run() {
	Num=$1; shift
	Str=$1; shift

	printf '\e[1;32m%0.2d: %s\e[0m\n' $Num "$Str"
	"$@"; Exit=$?
	[ $Exit -gt 0 ] && printf '\e[1;31mExit: %d\e[0m\n' $Exit

	printf 'Press <Enter> key to continue...'
	read _
}

Link='https://github.com/terminalforlife/PerlProjects/raw/master/source/ubuchk/ubuchk'
ListFile="$HOME/.config/fetcher/links"

#-----------------------------------------------------------------------Test #1

Run 1 'Display Usage() output...' bash "$Exec" -h

#-----------------------------------------------------------------------Test #2

if [ -f "$ListFile" ]; then
	Copied='True'
	cp "$ListFile" "$ListFile.old"
else
	1> "$ListFile"
fi

Run 2 'Display empty list...' bash "$Exec" list

#-----------------------------------------------------------------------Test #3

Run 3 'Add URL to list...' bash "$Exec" add "$Link"

#-----------------------------------------------------------------------Test #4

Run 4 'Display now-valid list...' bash "$Exec" list

#-----------------------------------------------------------------------Test #5

printf '1' | Run 5 'Remove URL from list...' bash "$Exec" remove
printf '\n'

#-----------------------------------------------------------------------Test #6

Run 6 'Looking for an empty list...' bash "$Exec" list

#-----------------------------------------------------------------------Test #7

Run 7 'Add URL to list, again...' bash "$Exec" add "$Link"


#-----------------------------------------------------------------------Test #8

Run 8 'Download file using saved URL...' bash "$Exec" fetch

#-----------------------------------------------------------------------Test #9

Run 9 'Check downloaded file exists...' stat -c "%a %s %u %g '%n'" "${Link##*/}"

#---------------------------------------------------------------------------End

# Restore user's original configuration file.
[ "$Copied" = 'True' ] && mv "$ListFile.old" "$ListFile"
