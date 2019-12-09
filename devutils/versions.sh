#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/devutils/versions.sh
# Started On        - Fri 25 Oct 12:41:34 BST 2019
# Last Change       - Mon  9 Dec 00:01:33 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------

. /usr/lib/tflbp-sh/Err
. /usr/lib/tflbp-sh/ChkDep
. /usr/lib/tflbp-sh/YNInput

ChkDep mimetype

cd "$HOME/GitHub/terminalforlife/Personal/Extra"

VerFile='versions'

for CurFile in source/*; do
	[ -f "$CurFile" ] || continue

	FileType=`mimetype -b "$CurFile"`

	if [ "${FileType#*/}" = 'x-shellscript' ]; then
		while IFS='=' read Key Value; do
			if [ "$Key" = 'CurVer' -o "$Key" = '_VERSION_' ]; then
				Version=${Value#?}
				Version=${Version%?}

				case $Version in
					[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])
						break ;;
					*)
						Err 0 "Invalid '$Key' value of '$Value'."
						continue 2 ;; # <-- Don't add this file to `versions`.
				esac
			fi
		done < "$CurFile"

		printf "${CurFile##*/}=$Version\n"
	fi
done 1> "$VerFile"

if YNInput "Add these changes to the staging area?"; then
	git add "$VerFile"

	if YNInput "Commit these and any other changes, now?"; then
		git commit -m 'Update `'"$VerFile"'`'
	fi
fi
