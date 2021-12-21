#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/compile-bash.sh
# Started On        - Mon  6 Dec 00:18:01 GMT 2021
# Last Change       - Tue 21 Dec 01:39:58 GMT 2021
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
#          N.N.N releases and `rc` releases are not included, yet.
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

	[[ $File =~ ^bash-[[:digit:]]+\.[[:digit:]]+\.tar\.gz$ ]] && Files+=("$File")
done <<< "$(wget -qO - "$URL")"

# Re-order the old-to-new sorted list of files to new-to-old.
TotalFiles=${#Files[@]}
for (( Start = TotalFiles - 1; Start >= 0; Start-- )); {
	SortedFiles+=("${Files[Start]}")
}

unset Files

#--------------------------------------------Get Target Tarball from User Input

printf 'Please \e[93mselect\e[0m a tarball of BASH to use.\n\n'

Count=1
for File in "${SortedFiles[@]}"; {
	(( Count > 10 )) && break

	printf '  %4s  %s\n' "($Count)" "$File"
	(( Count++ ))
}

unset Count File

printf '\n'

while :; do
	read -p '> ' GetVersion

	if [ -z "$GetVersion" ]; then
		Err 0 'Null response.'
		continue
	elif ! [[ $GetVersion =~ ^([123456789]|10)+$ ]]; then
		Err 0 'Invalid response.'
		continue
	fi

	ChosenFile=${SortedFiles[GetVersion - 1]}
	ChosenVersion=${ChosenFile#*-}
	ChosenVersion=${ChosenVersion%.tar.gz}
	printf 'You selected \e[92mBASH %s\e[0m -- continue?\n' "$ChosenVersion"
	while :; do
		read -p '> ' Confirm

		case $Confirm in
			[Yy]|[Yy][Ee][Ss])
				Happy='True'
				break ;;
			[Nn]|[Nn][Oo])
				Happy='False'
				break ;;
			'')
				Err 0 'Null response.' ;;
			*)
				Err 0 'Invalid response.' ;;
		esac
	done

	[ "$Happy" == 'True' ] && break
done

unset SortedFiles Happy GetVersion Confirm REPLY

#--------------------------------------------------------Configure Then Compile

if wget -q --show-progress "$URL/$ChosenFile"; then
	tar -xzvf "$ChosenFile" && rm -v "$ChosenFile"

	if cd "${ChosenFile%.tar.gz}"; then
		./configure
		make -j $Cores
	fi

	printf 'Done!\n'
fi
