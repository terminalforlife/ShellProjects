#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/devutils/cito-checker.sh
# Started On        - Fri  2 Jun 13:37:50 BST 2023
# Last Change       - Fri  2 Jun 17:33:00 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Run a series of tests on Cito. If you submit a PR for Cito, please ensure
# this works successfully. This must be executed from within the directory in
# which this script is found.
#------------------------------------------------------------------------------

Cito='../source/cito/cito'
if ! [[ -f $Cito ]]; then
	printf "Err: File '%s' not found.\n" "$Cito" 1>&2
	printf "     Are you within the 'devutils' directory?\n" 1>&2
	exit 1
elif ! [[ -r $Cito ]]; then
	printf "Err: File '%s' unreadable.\n" "$Cito" 1>&2
	exit 1
fi

Green=$'\e[32m'
Cyan=$'\e[36m'
Red=$'\e[31m'
Reset=$'\e[0m'

Header() {
	printf '\e[1m%s[%d] %s%s\n' "$Cyan" "$(( $1 + 1 ))" "$2" "$Reset"
}

BadMSG() {
	printf '\e[1m%s! %s%s\n' "$Red" "$1" "$Reset" 1>&2
}

TestNr=0
FailNr=0

#-----------------------------------------------------------------------Test #1

Header $(( TestNr++ ))\
	'Checking for syntax errors'

if ! sh -n "$Cito"; then
	(( FailNr++ ))

	BadMSG 'Syntax error(s) discovered'
fi

#-----------------------------------------------------------------------Test #2

Header $(( TestNr++ ))\
	'Looking for zombie code'

bash nozombies.sh "$Cito"
if (( $? == 4 )); then
	(( FailNr++ ))

	BadMSG 'Potential zombie code found'
fi

#-----------------------------------------------------------------------Test #3

Header $(( TestNr++ ))\
	'Testing `-h`|`--help` flag'

if ! sh "$Cito" -h | bash ./usage-checker.sh; then
	(( FailNr++ ))

	BadMSG 'Found problem(s) with usage output'
fi

#-----------------------------------------------------------------------Test #4

Header $(( TestNr++ ))\
	'Testing `-v`|`--version` flag'

VersionStr=`sh "$Cito" -v`
if ! [[ $VersionStr =~ ^[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}$ ]]; then
	(( FailNr++ ))

	printf "Version: '%s'\n" "$VersionStr"

	BadMSG 'Invalid version string'
fi

#-----------------------------------------------------------------------Test #5

# Much of this test is used in test #6.
Header $(( TestNr++ ))\
	'Testing installation of Cito-supported local file'

TempScript=`mktemp`

Mode=755
UserID=$UID
GroupID=`id -g`
Target="./.cito-test.tmp"

read -d '' <<-EOF
	#!/bin/sh
	#cito M:$Mode O:$UserID G:$GroupID T:$Target

	echo 'Test'
EOF

printf '%s' "$REPLY" > "$TempScript"

if ! sh "$Cito" "$TempScript"; then
	(( FailNr++ ))

	BadMSG "Cito failed to install temporary file"
elif ! [[ $(sh "$Target") == Test ]]; then
	(( FailNr++ ))

	BadMSG "Installed file executed unexpectedly"
fi

#-----------------------------------------------------------------------Test #6

Header $(( TestNr++ ))\
	'Testing installation of local file without Cito line'

read -d '' <<-EOF
	#!/bin/sh

	echo 'Test'
EOF

printf '%s' "$REPLY" > "$TempScript"

if ! sh "$Cito" -M $Mode -O $UserID -G $GroupID -T "$Target" "$TempScript"; then
	(( FailNr++ ))

	BadMSG "Cito failed to install temporary file"
elif ! [[ $(sh "$Target") == Test ]]; then
	(( FailNr++ ))

	BadMSG "Installed file executed unexpectedly"
fi

rm "$TempScript" "$Target"

#-----------------------------------------------------------------Print Summary

printf 'All checks completed.\n'

if (( FailNr > 1 || FailNr == 0 )); then
	FailStr='failures'
elif (( FailNr == 1 )); then
	FailStr='failure'
fi

if (( FailNr > 0 )); then
	FailColor=$Red
else
	FailColor=$Green
fi

printf '\n\e[1mDetected %s%d%s\e[1m %s out of %d test(s).\e[0m\n'\
	"$FailColor" $FailNr "$Reset" "$FailStr" $TestNr
