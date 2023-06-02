#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/nozombies.sh
# Started On        - Fri 26 May 19:32:02 BST 2023
# Last Change       - Fri  2 Jun 13:55:47 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Search for zombie shell code. Over the years, I've had a bad habit of leaving
# dead code in my projects. It's something I should probably stop doing, -
# because it can slow down reading comprehension and be mistakenly reanimated
# at a later date.
#
# Output is in grep(1)-style, and printed as hits are found.
#
# The following lines will not be shown:
#
#   - Lines with a shebang.
#   - Comment separator lines.
#   - Cito lines (e.g., '#cito ...').
#   - Comments with at least a space after.
#   - TODO comment lines.
#   - Trailing comments.
#
# Assumes filepaths don't have a pipe ('|') in them.
#
# Usage: $0 [FILE]
#
# Dependencies:
#
#   bash (>= 4.0)
#------------------------------------------------------------------------------

Err() {
	printf 'Err: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

GitDir='../source'
Repo='Extra'

[[ -d $GitDir ]] || Err 1 "Directory '$GitDir' not found."

shopt -s globstar

if [[ -n $1 ]]; then
	Files=$1

	if ! [[ -f $Files ]]; then
		Err 1 "File '$Files' not found."
	elif ! [[ -r $Files ]]; then
		Err 1 "File '$Files' unreadable."
	fi
else
	Files=("$GitDir"/**)
fi

ZombieHits=()
for File in "${Files[@]}"; {
	[[ -f $File ]] || continue
	[[ -r $File ]] || Err 0 "File '$File' unreadable."

	# Avoid non-scripts.
	read -n 2 < "$File"
	[[ $REPLY == '#!' ]] || continue

	LineNr=0
	while read -r; do
		(( LineNr++ ))

		Comment=
		PotentialHit=
		Len=${#REPLY}
		for (( Index = 0; Index < Len; Index++ )); {
			Char=${REPLY:Index:1}
			if [[ $PotentialHit == True ]]; then
				[[ ${REPLY:Index - 1:5} == TODO: ]] && break
				[[ ${REPLY:Index - 1:5} == 'cito ' ]] && break

				if [[ -n $1 ]]; then
					printf '\e[36m%d:\e[0m%s\n' "$LineNr" "$REPLY"
				else
					printf '\e[32m%s:\e[36m%d:\e[0m%s\n'\
						"$Repo/${File#*/}" "$LineNr" "$REPLY"
				fi

				break
			elif [[ $Comment == True ]]; then
				[[ $Char == [[:space:]] ]] && break
				[[ $Char != '-' && $Char != '!' ]] || break

				PotentialHit='True'
			elif [[ $Char != [[:space:]] ]]; then
				if [[ $Char == '#' ]]; then
					Comment='True'
				else
					break
				fi
			fi
		}
	done < "$File"
}
