#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/source/autoexec/dev/get_exec.sh
# Started On        - Sun 27 Jun 06:38:27 BST 2021
# Last Change       - Sun 27 Jun 06:47:50 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Developer script, likely temporary, to work an and hopefully overhaul AE's
# method of determine the correct executable, its flags, and processing the
# shebang. Exceptions can be handled if or when this gets sucked into AE.
#
# The following is the goal, in rough order:
#
# A) Determine whether to use shebang or the user's own, via the command-line.
#    The priority must be the latter.
#
# B) Process the shebang and the user's own 'Exec', without code duplication.
#    If it's a shebang, it's really important to handle `/usr/bin/env` cases, -
#    and this includes the odd chance the user provides a different path TO the
#    env(1) command.
#
# C) Be able to have 3 variables:
#
#    1. The full shebang or executable, without the leading `#!` and also
#       handle the spacing some users put between `#!` and the path. This must
#       include any flags the user may have added (IE: `/usr/bin/awk -f`).
#
#    2. The basename of the executable, either by processing a relative or
#       absolute path, or just the executable's filename itself. This is mainly
#       just for testing.
#------------------------------------------------------------------------------

File="$HOME/Desktop/TestDir/test.sh"

SheBang(){
	if [ -z "$1" ]; then
		read Line < "$File"
	else
		Line=$1
	fi

	Command=${Line#\#!}
	ExecPath=${Command%%* }
	ExecBase=${ExecPath##*/}

	echo "$Command"
	echo "$ExecPath"
	echo "$ExecBase"
}

SheBang '/usr/bin/bash -v'
