#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/devutils/compile-bash.sh
# Started On        - Mon  6 Dec 00:18:01 GMT 2021
# Last Change       - Sun  9 Jan 13:33:02 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# I'm usually on BASH 4.4 or whatever is available in my current Ubuntu-based
# installation of Linux. This means that I lose out on newer features of BASH.
#
# In order to both test my BASH programs in newer versions of BASH, and to just
# explore new features and to test any old code which might now be broken, I
# wrote this script to automate the process of getting versions of BASH.
#
# WARNING: This script does NOT (yet?) verify the signature of the tarball.
#
# Features:
#
#TODO: Maybe use the timestamp of the remote tarball to determine list order.
#
# Bugs:
#
# N/A
#
# Dependencies:
#
#   bash (>= 4.4.20)
#------------------------------------------------------------------------------

URL='https://mirror.lyrahosting.com/gnu/bash'

Err(){
	printf '\e[91mErr\e[0m: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

(( $# > 0 )) && Err 1 'This script takes no arguments.'

#-----------------------------------------------Determining Number of CPU Cores

ProcFile='/proc/cpuinfo'
if [[ -f $ProcFile && -r $ProcFile ]]; then
	while IFS=':' read Key Value; do
		Key=${Key##[[:space:]]}
		case ${Key%%[[:space:]]} in
			processor) TTLCores=${Value# } ;;
		esac
	done < "$ProcFile"
	(( Proc++ ))
elif type -P nproc &> /dev/null; then
	TTLCores=`nproc`
fi

[[ $TTLCores =~ ^[[:digit:]]+$ ]] || TTLCores=1

#------------------------------------------Generate List of Valid BASH Tarballs

while read; do
	[[ $REPLY =~ ^.*'>'(.*)'</a>'.*$ ]] || continue

	# Need this, because it gets scrapped when you use `=~` again, even if you
	# don't reuse the same captured group number.
	File=${BASH_REMATCH[1]}

	case $File in
		bash-[0-9]*.tar.gz)
			case $File in
				*alpha*|*beta*|*rc*)
					;;
				*)
					# BASH 2.0 failed to compile, so I'm just going to ignore
					# versions < 3.0, because let's face it, if you're running
					# those versions, you need much more than this script!
					case $File in
						bash-[12].*.tar.gz) continue ;;
					esac

					Files+=("$File") ;;
			esac ;;
	esac
done <<< "$(wget -qO - "$URL")"

#--------------------------------------------------------Configure Then Compile

for BASH in "${Files[@]}"; {
	[[ -d ${BASH%.tar.gz} ]] && continue

	if wget -q --show-progress "$URL/$BASH"; then
		tar -xzvf "$BASH" && rm -v "$BASH"

		(
			if cd "${BASH%.tar.gz}"; then
				./configure
				make -j $TTLCores
			fi
		)
	fi
}
