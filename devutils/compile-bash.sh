#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/compile-bash.sh
# Started On        - Mon  6 Dec 00:18:01 GMT 2021
# Last Change       - Fri 24 Dec 17:17:02 GMT 2021
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

ProcInfoFile='/proc/cpuinfo'
if [ -f "$ProcInfoFile" -a -r "$ProcInfoFile" ]; then
	while read -a Line; do
		if [ "${Line[0]}${Line[1]}" == 'cpucores' ]; then
			TTLCores=${Line[3]}
			break
		fi
	done < "$ProcInfoFile"
else
	TTLCores=`nproc`
fi

unset ProcInfoFile

Cores=$TTLCores

[[ $TTLCores =~ ^[[:digit:]]+$ ]] || Cores=1

printf 'Using %d/%d available CPU core(s).\n' $Cores $TTLCores

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
	[ -d "${BASH%.tar.gz}" ] && continue

	if wget -q --show-progress "$URL/$BASH"; then
		tar -xzvf "$BASH" && rm -v "$BASH"

		(
			if cd "${BASH%.tar.gz}"; then
				./configure
				make -j $Cores
			fi
		)
	fi
}
