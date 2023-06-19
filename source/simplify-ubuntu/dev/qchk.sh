#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/source/simplify-ubuntu/qchk.sh
# Started On        - Mon  1 Feb 00:47:10 GMT 2021
# Last Change       - Thu 17 Mar 18:32:22 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Simple developer script for parsing simplify-ubuntu(8) in order to check that
# each question number is in-fact unique.
#
# Usage: $0 FILE
#------------------------------------------------------------------------------

Err() {
	printf 'Err: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

if [[ -z $1 ]]; then
	Err 1 "File path not provided."
elif ! [[ -f $1 && -r $1 ]]; then
	Err 1 "File missing or unreadable."
elif (( $# != 1 )); then
	Err 1 'Argument required -- where is simplify-ubuntu(8)?'
fi

# Read file for IDs.
while read; do
	if [[ $REPLY =~ \[([[:digit:]]{4})\]: ]]; then
		Nr=${BASH_REMATCH[1]}

		# Omit leading zeroes.
		Found=
		Output=
		Len=${#Nr}
		for (( Char = 0; Char < Len; Char++ )); {
			CurChar=${Nr:Char:1}
			if [[ $Found == False ]]; then
				Output+=$CurChar
			elif (( CurChar != 0 )); then
				Output+=$CurChar
				Found='False'
			fi
		}

		AllIDs+=($Output)
	fi
done < "$1"

# Sort IDs.
Len=${#AllIDs[@]}
for (( Iter = 0; Iter < Len; Iter++ )); {
	Switched='False'
	for (( Index = 0; Index < Len - (1 + Iter); Index++ )); {
		if (( AllIDs[Index] < AllIDs[Index + 1] )); then
			Temp=${AllIDs[Index]}
			AllIDs[Index]=${AllIDs[Index + 1]}
			AllIDs[Index + 1]=$Temp

			Switched='True'
		fi
	}

	[[ $Switched == False ]] && break
}

# Check for duplicates.
for ID in "${AllIDs[@]}"; {
	(( ID == OldID )) && Err 0 "ID '$ID' duplicate(s) found."

	OldID=$ID
}
