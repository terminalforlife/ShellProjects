#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/devutils/update_hashes.sh
# Started On        - Thu  5 Dec 19:36:09 GMT 2019
# Last Change       - Fri  6 Dec 03:40:02 GMT 2019
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

SumFile='../md5sum'

if ! [ -r "$SumFile" -a -w "$SumFile" ]; then
	Err 1 "The '$SumFile' file has insufficient permissions."
fi

ChkDep md5sum git

ChkSums(){
	for CurFile in\
		../source/*\
		../source/libtflbp-sh/*\
		../source/completions/*\
		../source/cron_tasks/*
	do
		[ -d "$CurFile" ] && continue
		md5sum "$CurFile" | sed --posix 's/\.\.\///'
	done
}

if YNInput 'Do you want to save the md5sums?'; then
	ChkSums > "$SumFile"
	if YNInput 'Add then commit the file changes?'; then
		git add "$SumFile"
		git commit -m "Update 'md5sum' file"
	fi
else
	ChkSums
fi
