#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/hashes.sh
# Started On        - Thu  5 Dec 19:36:09 GMT 2019
# Last Change       - Fri 31 Jan 03:06:30 GMT 2020
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# I wrote this to handle updating the md5sum of various files in this
# repository. This script was written with Bourne POSIX-compliance in mind.
#
# You could refactor this to fit your needs.
#------------------------------------------------------------------------------

set -e
. /usr/lib/tflbp-sh/Err
. /usr/lib/tflbp-sh/ChkDep
set +e

cd "$HOME/GitHub/terminalforlife/Personal/Extra"

SumFile='md5sum'

if ! [ -f "$SumFile" ]; then
	Err 0 "The '$SumFile' file is missing."
elif ! [ -r "$SumFile" -a -w "$SumFile" ]; then
	Err 1 "The '$SumFile' file has insufficient permissions."
elif ! [ -s "$SumFile" ]; then
	Err 0 "The '$SumFile' file is entirely empty."
fi

ChkDep md5sum git

SetSums(){
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

SetSums > "$SumFile"
