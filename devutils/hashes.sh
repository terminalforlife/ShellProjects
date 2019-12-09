#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/devutils/hashes.sh
# Started On        - Thu  5 Dec 19:36:09 GMT 2019
# Last Change       - Sun  8 Dec 23:59:42 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# I wrote this to handle updating the md5sum of various files in this repository.
# This script was written with Bourne POSIX-compliance in mind.
#
# You could refactor this to fit your needs, but as it is, I would leave it alone.
#----------------------------------------------------------------------------------

. /usr/lib/tflbp-sh/Err
. /usr/lib/tflbp-sh/ChkDep
. /usr/lib/tflbp-sh/YNInput

cd "$HOME/GitHub/terminalforlife/Personal/Extra"

SumFile='md5sum'

if ! [ -f "$SumFile" ]; then
	Err 0 "The '${SumFile##*/}' file is missing."
elif ! [ -r "$SumFile" -a -w "$SumFile" ]; then
	Err 1 "The '${SumFile##*/}' file has insufficient permissions."
elif ! [ -s "$SumFile" ]; then
	Err 0 "The '${SumFile##*/}' file is entirely empty."
fi

ChkDep md5sum git

ChkSums(){
	for CurFile in\
		source/*\
		source/libtflbp-sh/*\
		source/completions/*\
		source/cron_tasks/*
	do
		[ -d "$CurFile" ] && continue
		[ -f source/README.md ] && continue
		md5sum "$CurFile"
	done
}

if md5sum -c md5sum 1> /dev/null 2>&1; then
	printf "Nothing to do -- quitting.\n"
	exit 0
fi

ChkSums > "$SumFile"

if YNInput "Add these changes to the staging area?"; then
	git add "$SumFile"

	if YNInput "Commit these and any other changes, now?"; then
		git commit -m 'Update `'"${SumFile##*/}"'`'
	fi
fi
