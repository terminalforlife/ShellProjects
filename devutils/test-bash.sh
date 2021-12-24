#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/test-bash.sh
# Started On        - Mon 20 Dec 15:11:15 GMT 2021
# Last Change       - Fri 24 Dec 12:15:40 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Runs various pre-compiled versions of BASH (>= 3.0) with whichever script is
# handed to this file. This is for testing features and to find out what is
# available in which shell. The annoying part of shell programming!
#
# This is intended to be used in tandem with 'compile-bash.sh'.
#------------------------------------------------------------------------------

Err() {
	printf 'Err: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

if ! [ -f "$1" ]; then
	Err 1 'File not found.'
elif ! [ -r "$1" ]; then
	Err 1 'File unreadable.'
else
	# Verify the shebang is actually pointing to BASH. Reduces the chance of
	# accidentally trying to run the wrong file a bazillion times.
	read <<< "$(file "$1")"
	Str='Bourne-Again shell script, ASCII text executable'
	[[ ${REPLY#*: } == $Str ]] || Err 1 'File not a BASH script.'
fi

for BASH in "$HOME"/BASH/*; {
	[ -d "$BASH" ] || continue

	printf '\e[1;92m* \e[91m%s:\e[0m\n' "${BASH##*/}"
	"$BASH"/bash "$1"

	#Result=$("$BASH"/bash -n "$1" 2>&1)
	#if (( $? != 0 )); then
	#	printf '\e[1;92m* \e[91m%s:\e[0m\n' "${BASH##*/}"
	#	printf '%s\n\n' "$Result"
	#fi
}
