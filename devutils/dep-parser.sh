#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/dep-parser.sh
# Started On        - Tue  2 Mar 15:21:35 GMT 2021
# Last Change       - Tue  2 Mar 16:21:28 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Determine dependencies as found in header of each provided file. The code
# here is indended to be reused within TFL installer scripts, but this script
# specifically is independent therefrom.
#------------------------------------------------------------------------------

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

if [ $# -gt 0 ]; then
	while read -r Line; do
		printf '%b\n' "$Line"
	done <<-EOF

		\rNOTE: The following is a list of dependencies you'll need to acquire
		\r      before you can properly or at all use what this installer
		\r      provides. The dependencies listed below are taken from (parsed)
		\r      directly from the files themselves.

		\r      These are package names as they exist in Debian and Ubuntu.
	EOF
else
	printf 'Usage: %s [FILE_1 [FILE_2] ...]\n' "${0##*/}" 1>&2
	exit 1
fi

#-----------Below is Used in TFL Installers (`for` LIST is changed accordingly)

printf 'Checking for dependencies:\n'

for File in "$@"; do
	printf "* Looking in '%s' file...\n" "$File"

	FileErr=0
	if ! [ -f "$File" ]; then
		Err 0 "File '$File' missing."
		FileErr=$((FileErr + 1))
	elif ! [ -r "$File" ]; then
		Err 0 "File '$File' unreadable."
		FileErr=$((FileErr + 1))
	fi

	if [ $FileErr -ne 0 ]; then
		Err 0 'Unable to determine dependencies.'
		continue
	fi

	DepErr=0
	Found='False'
	while read Line; do
		if [ "$Line" = '#' ]; then
			continue
		elif [ "$Line" = '# Dependencies:' ]; then
			Found='True'
		elif [ "$Found" = 'True' ]; then
			# Line to help debug parsing on stubborn files.
			#printf '\e[2;37m%s\e[0m\n' "$Line"

			case $Line in
				'#'------*)
					break ;;
				*)
					case $Line in
						'#   '[!\ ]*)
							printf '\033[1;91m%s\e[0m\n' "${Line#\#   }" ;;
						*|'')
							DepErr=$((DepErr + 1)) ;;
					esac ;;
			esac
		fi
	done < "$File"

	[ $DepErr -eq 0 ] || Err 0 'One or more invalid dependencies detected.'
done

printf 'Done!\n'
