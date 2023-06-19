#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/devutils/fix-project-names.sh
# Started On        - Wed  7 Jun 20:21:59 BST 2023
# Last Change       - Thu  8 Jun 17:38:13 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Update 'Project Name' and 'Last Change' parts of headers like the above. This
# is needed for when I've renamed files but not updated the project name. If a
# change is made, the latter value gets updated as well.
#
# It's here, after all these years, that I discovered `read` butchers leading
# and trailing spaces when you specify a variable name into which to store
# data. Yet, this doesn't happen if you use the default `$REPLY` variable. This
# probably went under my radar because I almost exclusively use the default.
#
# This is not suitable for other people to run, because it expects the same
# directory structure as I have over on my end. If you do want to use it, you
# will need to use a very similar path for `$Dir`.
#
# WARNING: This script is immediately destructive across ALL repositories!
#
#TODO: Files with empty project names are not correclty handled.
#
# Dependencies:
#
#   bash (>= 4.2)
#------------------------------------------------------------------------------

Dir="$HOME/GitHub/terminalforlife/Personal"

for Repo in "$Dir"/*; {
	[[ -d $Repo ]] || continue

	for File in "$Repo"/source/{*,*/*}; {
		[[ -f $File ]] || continue

		read -n 2 < "$File"
		[[ $REPLY == '#!' ]] || continue

		Lines=()
		LineNr=1
		Replaced=
		while read -r; do
			if (( LineNr == 4 )); then
				if [[ $REPLY == '# Project Name'+(\ )-\ * ]]; then
					RepoName=${Repo##*/}
					New="${REPLY%% - *} - $RepoName${File#$Repo}"

					if [[ $REPLY != $New ]]; then
						Replaced='True'
						REPLY=$New
					fi
				fi
			elif (( LineNr == 6 )); then
				if [[ $REPLY == '# Last Change'+(\ )-\ * ]]; then
					if [[ $Replaced == True ]]; then
						printf -v Now '%(%a %e %b %H:%M:%S %Z %Y)T' -1
						REPLY="${REPLY% - *} - $Now"
					fi
				fi
			fi

			Lines+=("$REPLY")

			(( LineNr++ ))
		done < "$File"

		printf '%s\n' "${Lines[@]}" > "$File"
	}
}
