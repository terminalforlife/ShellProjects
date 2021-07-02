#!/usr/bin/env bash
#cito M:755 O:0 G:0 T:/usr/bin/dura
#------------------------------------------------------------------------------
# Project Name      - Extra/source/dura
# Started On        - Thu  1 Jul 12:01:03 BST 2021
# Last Change       - Fri  2 Jul 03:31:08 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Display the duration of a video file, or the total duration of multiples.
# Sadly, due to the lack of floating support in BASH, the seconds will not be a
# floating number, so this will only be accurate up to the second.
#
# Untested past lengths of 99:99:99.
#
# Features:
#
# N/A
#
# Bugs:
#
# N/A
#
# Dependencies:
#
#   bash (>= 4.3-14)
#   ffmpeg (>= 7:3.4.8-0)
#------------------------------------------------------------------------------

CurVer='2021-07-02'
Progrm=${0##*/}

Usage(){
	while read; do
		printf '%s\n' "$REPLY"
	done <<-EOF
		Usage: $Progrm [OPTS] [FILE_1 [FILE_2] ...]

		  -h, --help               - Display this help information.
		  -v, --version            - Output the version datestamp.

		Results will be accurate up to the second.
	EOF
}

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

while [ "$1" ]; do
	case $1 in
		--help|-h|-\?)
			Usage; exit 0 ;;
		--version|-v)
			printf '%s\n' "$CurVer"; exit 0 ;;
		-*)
			Err 1 'Incorrect option(s) specified.' ;;
		*)
			break ;;
	esac
	shift
done

if (( $# == 0 )); then
	Err 1 'One or more file paths required.'
fi

if ! type -P ffprobe &> /dev/null; then
	Err 1 "Dependency 'ffprobe' not met."
fi

for File in "$@"; {
	if ! [ -f "$File" ]; then
		Err 0 "File missing: $File"
	elif ! [ -r "$File" ]; then
		Err 0 "File unreadable: $File"
	fi

	while read -a Line; do
		if [ "${Line[0]}" == 'Duration:' ]; then
			declare -A Lens[${Line[1]%.[[:digit:]][[:digit:]],}]=$File
			break
		fi
	done <<< "$(ffprobe "$File" 2>&1)"
}

# List files and their durations.
for Stamp in "${!Lens[@]}"; {
	printf '%-#8s <- \e[37m%s\e[0m\n' "$Stamp" "${Lens[$Stamp]}"
}

(( $# == 1 )) && exit 0

# Add up all of the seconds from the hours, minutes, and remaining seconds.
for Time in "${!Lens[@]}"; {
	IFS=':' read HH MM SS <<< "$Time"

	# Needed to avoid `let` freaking out thinking it's looking at octals.
	HH=${HH##0}; MM=${MM##0}; SS=${SS##0}

	let SecondTTL+=$(( HH * 3600 ))
	let SecondTTL+=$(( MM * 60 ))
	let SecondTTL+=SS
}

# Display hours, minutes, and the remaining seconds determined from the above
# block, deducting from the SecondsTTL each step of the way, until just the
# seconds are left to display. Format them accordingly.
HH=$(( SecondTTL / 3600 ))
SecondTTL=$(( SecondTTL - (HH * 3600) ))
MM=$(( SecondTTL / 60 ))
SecondTTL=$(( SecondTTL - (MM * 60) ))

printf '\e[92m%02d:%02d:%02d\e[0m\n' $HH $MM $SecondTTL
