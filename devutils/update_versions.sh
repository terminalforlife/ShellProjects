#!/usr/bin/env bash

#----------------------------------------------------------------------------------
# Project Name      - Extra/devutils/update_versions.sh
# Started On        - Fri 25 Oct 12:41:34 BST 2019
# Last Change       - Fri  6 Dec 03:30:04 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Fetches then saves versions deemed by current-directory shell prorams' initial
# _VERSION_ variable, in key=value format. Parsing only; no program is executed.
#----------------------------------------------------------------------------------

echo "Don't use this yet! Needs to be updated..."

exit

. /usr/lib/tflbp-sh/Err
. /usr/lib/tflbp-sh/ChkDep
. /usr/lib/tflbp-sh/YNInput

VER_FILE='./versions'

ChkDep mimetype

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
		YNInput "Overwrite '$VER_FILE' file?" || exit 0
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
		Err 1 "Invalid response -- quitting." ;;
esac
