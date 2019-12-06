#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/update_hashes.sh
# Started On        - Thu  5 Dec 19:36:09 GMT 2019
# Last Change       - Fri  6 Dec 03:06:10 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# I wrote this to handle updating the md5sum of various files in this repository.
# This script was written with Bourne POSIX-compliance in mind.
#
# You could refactor this to fit your needs, but as it is, I would leave it alone.
#----------------------------------------------------------------------------------

. /usr/lib/tflbp-sh/ChkDep
. /usr/lib/tflbp-sh/YNInput

SumFile='md5sum'

if ! [ -r "$SumFile" -a -w "$SumFile" ]; then
	Err 1 "The '$SumFile' file has insufficient permissions."
fi

ChkDep md5sum

Excepts='
	LICENSE
	README.md
	md5sum
	update_hashes.sh
	update_links.sh
	update_standard.sh
	update_versions.sh
	versions
'

ChkSums(){
	for CurFile in *; do
		for CurExcept in $Excepts; do
			[ "$CurExcept" = "$CurFile" ] && continue 2
		done

		[ -d "$CurFile" ] && continue
		md5sum "$CurFile"
	done
}

if YNInput 'Do you want to save the md5sums?'; then
	ChkSums > "$SumFile"
	if YNInput 'Add then commit the file changes?'; then
		git add "$SumFile"

		ComSum="Update '$SumFile' with new md5sums"
		[ ${#ComSum} -lt 50 ] || Err 1 'Commit message exceeds maximum length.'

		git commit -m "$ComSum"
	fi
else
	ChkSums
fi
