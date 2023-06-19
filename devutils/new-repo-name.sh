#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/devutils/new-repo-name.sh
# Started On        - Mon 19 Jun 23:39:54 BST 2023
# Last Change       - Tue 20 Jun 00:12:25 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Interactively update files to handle the repository being renamed. This is
# only specific to my projects, and won't be much use elsewhere. As much as I'd
# love to automate the entire thing, it has to be semi-automatic to save making
# a bloody mess!
#------------------------------------------------------------------------------

Dir="$HOME/GitHub/terminalforlife/Personal"

Err() {
	printf 'Err: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

printf 'NOTE: If prompted, no Enter is required.\n'
for Repo in "$Dir"/*; {
	[[ -d $Repo ]] || continue

	for File in "$Repo"/source/{*,*/*}; {
		[[ -f $File ]] || continue

		read -n 2 < "$File"
		[[ $REPLY == '#!' ]] || continue

		Name=${File#$Dir/}
		BaseName=${Name##*/}
		DirName=${Name#*/}
		DirName=${DirName%/*}
		RepoName=${Name%%/*}

		readarray -t < "$File"

		Shown=
		Len=${#MAPFILE[@]}
		for (( Index = 0; Index < Len; Index++ )); {
			LineNr=$(( Index + 1 ))
			if [[ ${MAPFILE[Index]} == *Extra* ]]; then
				if [[ $Shown != True ]]; then
					printf -- '* \e[2;37m%s\e[0m\e[37m/%s/\e[0m\e[93m%s\e[0m\n'\
						 "$RepoName" "$DirName" "$BaseName"

					Shown='True'
				fi

				printf '\e[92m%*d:\e[0m %s\n' ${#Len} $LineNr\
					"${MAPFILE[Index]//Extra/$'\e[91m'Extra$'\e[0m'}"

				while :; do
					read -n 1 -ep 'Replace? (Y/N) '

					case ${REPLY,,} in
						y)
							sed -i "${LineNr}s/Extra/ShellProjects/" "$File"
							break ;;
						n)
							break ;;
						'')
							Err 0 'Empty response -- try again.' ;;
						*)
							Err 0 'Unrecognised response -- try again.' ;;
					esac
				done
			fi
		}
	}
}
