#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - update_versions.sh
# Started On        - Fri 25 Oct 12:41:34 BST 2019
# Last Change       - Wed 27 Nov 15:56:54 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Fetches then saves versions deemed by current-directory shell prorams' initial
# _VERSION_ variable, in key=value format. Parsing only; no program is executed.
#----------------------------------------------------------------------------------

VER_FILE='./versions'

declare -a EXCEPTIONS=(
	autostart
	update_links.sh
	update_versions.sh
)

Err(){
	printf "[L%0.4d] ERROR: %s\n" "$2" "$3" 1>&2
	[ $1 -eq 1 ] && exit 1
}

printf "%s " "Confirming 'mimetype' exists..."

if ! type -fP mimetype &> /dev/null; then
	Err 1 $LINENO "Unable to find 'mimetype' in PATH."
else
	printf " [OK]\n"
fi

printf "%s " "Gathering version strings..."

DATA="$(\
	for F in *; {
		MIME=`mimetype -b "$F" 2> /dev/null`

		for EXCEPT in ${EXCEPTIONS[@]}; {
			[ "$F" == "$EXCEPT" ] && continue 2
		}

		if [[ $MIME == *x-shellscript ]]; then
			while IFS='=' read -a L; do
				[ "${L[0]}" == '_VERSION_' ] && V=${L[1]}
			done < "$F"

			printf "%s=%s\n" "$F" "${V//\"}"
		fi
	}
)"

printf " [OK]\n"

SAVE(){
	if [ -f "$VER_FILE" ]; then
		read -n 1 -e -p "[O]verwrite '$VER_FILE', or [q]uit? " OQ
		case $OQ in
			[Oo])
				;;
			[Qq])
				exit 0 ;;
			*)
				Err 1 $LINENO "Invalid response -- quitting." ;;
		esac
	fi

	printf "Writing data to: '%s'" "$VER_FILE"
	printf "%s\n" "$DATA" > "$VER_FILE"
	printf " [OK]\n"
}

read -n 1 -e -p "[V]iew, [s]ave, [b]oth, or [q]uit? " VSBQ
case $VSBQ in
	[Vv])
		printf "\n%s\n" "$DATA" ;;
	[Ss])
		SAVE ;;
	[Bb])
		printf "\n%s\n\n" "$DATA"
		SAVE ;;
	[Qq])
		exit 0 ;;
	*)
		Err 1 $LINENO "Invalid response -- quitting." ;;
esac
