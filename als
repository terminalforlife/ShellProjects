#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/als
# Started On        - Wed 27 Nov 21:28:12 GMT 2019
# Last Change       - Thu 28 Nov 00:56:21 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Written with a Reddit post in mind, but could an interesting side project.
# Although the aforementioned post was on 'r/bash', I've opted instead for `sh`.
#
# In order to keep the syntax as POSIX I am able, I've written this under `yash`.
#----------------------------------------------------------------------------------

set -- --help -A --padmod $HOME/Documents/*

CurVer="2019-11-27"
Progrm=${0##*/}

Usage(){
	while read -r CurLine; do
		printf "%b\n" "$CurLine"
	done <<-EOF
		\r            ALS ($CurVer)
		\r            Written by terminalforlife (terminalforlife@yahoo.com)
		\r
		\r            A portable Bourne Shell filesystem traversal utility.
		\r
		\rSYNTAX:     $Progrm [OPTS]
		\r
		\rOPTS:       --help|-h|-?            - Displays this help information.
		\r            --version|-v            - Output only the version datestamp.
		\r            --quiet|-q              - Runs in quiet mode. Errors still output.
		\r            --debug|-D              - Enables the built-in Bourne debugging.
		\r
		\r            --all|-A                - Enable displaying of all hidden files.
		\r
		\r            --padmod                - Zero-pad mode integers. IE: '0600'
		\r            --padid                 - Zero-pad UID & GID integers. IE: '0924'
		\r
		\r            --size|-s               - Show the file sizes; in bytes, by default.
		\r            --human|-h [K|M|G]      - Show file sizes in 'K', 'M', or 'G'.
		\r
		\rNOTE:       ALS supports the special '--' argument to signal the end of
		\r            argument processing; handy for filenames beginning with '-'.
		\r
		\r            While the standard 'ls' command will (optionally) display the
		\r            unique '.' and '..' files expected in every directory, ALS won't.
		\r
		\rSITE:       $DOM/terminalforlife/Extra
	EOF

	unset CurLine
}

Err(){
	printf "ERROR: %s\n" "$2" 1>&2
	[ $1 -eq 1 ] && exit 1
}

ShowSize='B'

while [ -n "$1" ]; do
	case $1 in
		--help|-h|-\?)
			Usage; exit 0 ;;
		--version|-v)
			printf "%s\n" "$_VERSION_"; exit 0 ;;
		--all|-A)
			ShowAll='* .*' ;;
		--padmod)
			PadModes='true' ;;
		--padid)
			PadIDs='true' ;;
		--size|-s)
			ShowSize='true' ;;
		--human|-h)
			shift
			case $1 in
				[Kk]|[Mm]|[Gg])
					ShowSize=$1 ;;
				[Bb])
					Err 1 "To display in bytes, omit the '--human|-h' option." ;;
				*)
					Err 1 'Invalid file size type specified.' ;;
			esac ;;
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
	GetSize(){
		case $HumanBy in
			B)
				printf "%-d" "$1" ;;
			K)
				;;
			M)
				;;
			G)
				;;
		esac
	}

	StatFormat='%a %u %g %s %X %Y:%n'

	# Get information for each file given to `FileStat()` and parse the results.
	for CurFile in "$@"; do
		CurFileData=`stat --printf="$StatFormat" "$CurFile"`

		# Parse the fields one-by-one in order to correctly format them.
		# Fields: 1=Modes, 2=UID, 3=GID, 4=Bytes, 5=Access, 6=Mod, 7=Name
		FieldCount=0
		for CurField in ${CurFileData%%:*}; do
			FieldCount=$((FieldCount + 1))
			[ $FieldCount -eq 7 ] && break

			if [ $FieldCount -eq 1 ]; then
				if [ "$PadModes" = 'true' ]; then
					printf "%-0.4d" "$CurField"
				else
					printf "%-d" "$CurField"
				fi
			elif [ $FieldCount -eq 2 -o $FieldCount -eq 3 ]; then
				if [ "$PadIDs" = 'true' ]; then
					printf "%-0.4d" "$CurField"
				else
					printf "%-d" "$CurField"
				fi
			elif [ $FieldCount -eq 4 ]; then
				printf "%-d" "$(GetSize "$CurField")"
			else
				# Avoid unwanted padding otherwise added below.
				continue
			fi

			# Saves needing to remember the trailing whitespace.
			printf " "
		done

		# Now print the file name.
		printf "%-s" "${CurFileData##*:}"

		# Needed to avoid text-vomit.
		printf "\n"
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
