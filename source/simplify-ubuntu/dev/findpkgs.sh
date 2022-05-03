#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/source/simplify-ubuntu/dev/findpkgs.sh
# Started On        - Tue  3 May 23:02:03 BST 2022
# Last Change       - Tue  3 May 23:10:41 BST 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Output all of the arguments for the `FindPKG()` calls; essentially, this will
# result in a list of possible targeted packages in simplify-ubuntu(8).
#------------------------------------------------------------------------------

Repo="$HOME/GitHub/terminalforlife/Personal/Extra"
File="$Repo/source/simplify-ubuntu/simplify-ubuntu"

if [[ -f $File && -r $File ]]; then
	while read -r; do
		if [[ $REPLY == *if\ FindPKG\ * ]]; then
			Str=${REPLY#*if FindPKG }
			Str=${Str%; then}
			printf '%s\n' "${Str%\\}"
		fi
	done < "$File"
fi
