#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/als
# Started On        - Wed 27 Nov 21:28:12 GMT 2019
# Last Change       - Thu 28 Nov 00:09:57 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Written with a Reddit post in mind, but could an interesting side project.
# Although the aforementioned post was on 'r/bash', I've opted instead for `sh`.
#
# In order to keep the syntax as POSIX I am able, I've written this under `yash`.
#----------------------------------------------------------------------------------

set -- -A

CurVer="2019-11-27"
Progrm=${0##*/}

Usage(){
	while read CurLine; do
		printf "%s\n" "$REPLY"
	done <<-EOF
		            ALS -- Alternative LS ($CurVer)
		            Written by terminalforlife (terminalforlife@yahoo.com)

		            A portable Bourne Shell filesystem traversal utility.

		SYNTAX:     $Progrm [OPTS]

		OPTS:       --help|-h|-?            - Displays this help information.
		            --version|-v            - Output only the version datestamp.
		            --quiet|-q              - Runs in quiet mode. Errors still output.
		            --update|-U             - Check for updates to $Progrm.
		            --debug|-D              - Enables the built-in Bourne debugging.
		            --all|-A                - Enable displaying of all hidden files.

		NOTE:       ALS supports the special '--' argument to signal the end of
		            argument processing; handy for filenames beginning with '-'.

		            While the standard 'ls' command will (optionally) display the
		            unique '.' and '..' files expected in every directory, ALS won't.

		SITE:       $DOM/terminalforlife/Extra
	EOF

	unset CurLine
}

Err(){
	printf "ERROR: %s\n" "$2" 1>&2
	[ $1 -eq 1 ] && exit 1
}

while [ -n "$1" ]; do
	case $1 in
		--help|-h|-\?)
			Usage; exit 0 ;;
		--version|-v)
			printf "%s\n" "$_VERSION_"; exit 0 ;;
		--all|-A)
			ShowAll='* .*' ;;
		--)
			ArgEnd='--'
			break ;;
		-*)
			Err 1 "Incorrect argument(s) specified." ;;
		*)
			break ;;
	esac
	shift
done

MoreArgs=$*

[ "$DEBUGME" == "true" ] && set -x

SplitStr(){
	IFS=$1
	shift

	set -- $2
	printf "%s\n" "$@"
	unset IFS
}

ChkPath(){
	for CurDir in `SplitStr ':' "$PATH"`; do
		for CurFile in "$CurDir"/*; do
			if [ "$CurFile" = "$1" ]; then
				ExecFound='true'
				break 2
			fi
		done
	done

	if ! [ "$ExecFound" = 'true' ]; then
		unset CurDir CurFile ExecFound
		return 0
	else
		unset CurDir CurFile ExecFound
		return 1
	fi
}

ChkPath 'stat' || Err 1 "Dependency 'stat' not met."

FileStat(){
	SepCode='kgOFTnpXdBWnrXHLycJQgRrfROx'

	# Concatenate the results of `stat`, field-by-field, to insert SepCode.
	RawStatFormat='%a %u %g %s %X %Y %n'
	for CurField in $RawStatFormat; do
		StatFormat="$StatFormat$SepCode$CurField$SepCode"
	done

	# Get information for each file given to `FileStat()` and parse the results.
	for CurFile in "$@"; do
		CurFileData=`stat --printf="$StatFormat" "$CurFile"`

		SplitStr "$SepCode" "$CurFileData"
		exit

#------------------------^ WORKING HERE ^------------------------------------------

		# Parse the fields one-by-one in order to correctly format them.
		# Fields: 1=Modes, 2=UID, 3=GID, 4=Bytes, 5=Access, 6=Mod, 7=Name
		FieldCount=0
		for CurField in `SplitStr "$SepCode" "$CurFileData"`; do
			FieldCount=$((FieldCount + 1))
			printf "%s " "$CurField"
		done

		# Remove trailing whitespace, then begin a new line.
		printf "\b\n"
	done

	unset CurField SepCode RawStatFormat StatFormat StatData FieldCount CurFileData
}

if [ $# -gt 0 ]; then
	# When the user does specify file(s) to list.
	FileStat "$@"
else
	# Standard, non-recursive list of all files in the CWD.
	for CurFile in ${ShowAll:-*}; do
		if [ -n "$ShowAll" ]; then
			if [ "$CurFile" = '.' -o "$CurFile" = '..' ]; then
				# Don't want to see these files; this ain't `ls`!
				continue
			fi
		fi

		FileStat "$CurFile"
	done
fi
