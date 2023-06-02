#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/usage-checker.sh
# Started On        - Fri  2 Jun 16:03:20 BST 2023
# Last Change       - Fri  2 Jun 17:30:47 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Parse usage output from STDIN to ensure all is correct.
#------------------------------------------------------------------------------

Err() {
	printf 'Err: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

if (( $# != 0 )); then
	Err 1 'No arguments required.'
fi

#---------------------------------------------------Check Line Length of Output

LineNr=0
Errors=0
while read -r; do
	(( LineNr++ ))
	Len=${#REPLY}

	if (( Len > 80 )); then
		(( Errors++ ))

		printf '[L%d] Line length > 80\n' $LineNr
	fi

	if (( LineNr == 1 )); then
		Start=
		Buffer=
		GotName=
		for (( Index = 0; Index < Len; Index++ )); {
			Char=${REPLY:Index:1}
			if [[ $GotName == True ]]; then
				if [[ $Char == [[:lower:]] ]]; then
					(( Errors++ ))

					printf '[L%d] Unexpected lowercase letters\n' $LineNr

					break
				fi
			elif [[ $Start == True ]]; then
				[[ $Char == ' ' ]] && GotName='True'
			elif (( Index == 7 )); then
				if [[ $Buffer == 'Usage: ' ]]; then
					Start='True'
				else
					(( Errors++ ))

					printf '[L%d] Unexpected output\n' $LineNr
				fi
			else
				Buffer+=$Char
			fi
		}
	elif (( LineNr == 2 )) && [[ -n $REPLY ]]; then
		(( Errors++ ))

		printf '[L%d] Line not empty\n' $LineNr
	elif (( LineNr > 2 )); then
		Start=
		Buffer=
		Spaces=0
		for (( Index = 0; Index < Len; Index++ )); {
			Char=${REPLY:Index:1}
			if (( Index == 0 )) && [[ $Char == $'\r' ]]; then
				: # <-- We're on a POSIX shell script.
			elif [[ $Char == ' ' ]]; then
				(( Spaces++ ))
			else
				if (( Spaces != 2 )); then
					(( Errors++ ))

					printf '[L%d] Improper indentation\n' $LineNr
				fi

				Spaces=0

				break
			fi
		}

		if [[ ${REPLY:28:1} != '-' ]]; then
			(( Errors++ ))

			printf '[L%d] Incorrect description alignment\n' $LineNr
		elif [[ ${REPLY:29:1} != ' ' || ${REPLY:30:1} == ' ' ]]; then
			(( Errors++ ))

			printf '[L%d] Incorrect description padding\n' $LineNr
		fi
	fi
done < /dev/stdin

if (( Errors > 0 )); then
	exit 2
fi
