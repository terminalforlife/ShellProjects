#!/usr/bin/env bash

#----------------------------------------------------------------------------------
# Project Name      - Extra/devutils/update_standard.sh
# Started On        - Thu  5 Dec 12:56:08 GMT 2019
# Last Change       - Fri  6 Dec 03:31:29 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Just a personal, temporary development tool to update the syntax standards of my
# shell programs and small scripts. I have so many that this will be a time-saver.
#
# You could make use of some of this, though.
#----------------------------------------------------------------------------------

. /usr/lib/tflbp-sh/Err
. /usr/lib/tflbp-sh/ChkDep

#set -- "$HOME/GitHub/terminalforlife/Personal/Extra/source/lspkg"

POSIXLY_CORRECT='y'

ChkDep grep sed

CurFile=$1
shift

if [ -z "$CurFile" ]; then
	Err 1 "Bash script must be provided."
elif ! [ -f "$CurFile" -a -r "$CurFile" -a -w "$CurFile" ]; then
	Err 1 "Bash script missing or inaccessible."
elif ! grep -qxE '#!/(bin/bash|/usr/bin/env bash)' "$CurFile"; then
	Err 1 "Provided file is not a Bash script."
elif ! [ $UID -eq 1000 -a $USER == 'ichy' ]; then
	Err 1 "This script is not for you."
fi

SaR(){ sed --posix -ri "$*" "$CurFile" &> /dev/null || Err 1 "$*"; }

# Prefer `CurVer` over `_VERSION`, and `Progrm` over `_PROJECT_`.
SaR "s/^_VERSION_=\"(.*)\"/CurVer='\\1'/"
SaR "s/^CurVer=\"(.*)\"/CurVer='\\1'/"
SaR 's/_VERSION_/CurVer/g'
SaR "s/^_PROJECT_=(.*)/Progrm=\\1/"
SaR 's/^_PROJECT_="(\$\{0##\*\/\})"/Progrm=\1/'
SaR 's/^Progrm="(\$\{0##\*\/\})"/Progrm=\1/'
SaR 's/_PROJECT_/Progrm/g'

# Needs to be corrected for my `todo` function, and for consistency.
SaR 's/#TODO: /#TODO - /'

# Prefer `Err()` over `FAIL()`.
SaR 's/^FAIL(\(\)\{)/Err\1/'
SaR 's/FAIL( [10]{1} )/Err\1/'
SaR 's/"\$LINENO"/\$LINENO/g'

# Use traditional case for function and variable names.
SaR "s/^DOM=\"(.*)\"/Domain='\\1'/"
SaR 's/\$DOM/$Domain/'
SaR 's/USAGE\(\)\{/Usage\(\)\{/'
SaR 's/USAGE\;/Usage\;/'
SaR 's/\$DEBUGME/\$DebugMe/g'
SaR 's/DEBUGME=/DebugMe=/g'

# Remove expanded program/script title from `Usage()`; keeping it consistent.
SaR 's/(\$\{Progrm\^\^\}) - .* (\(\$CurVer\))/\1 \2/'

# Prefer Bash syntax for STDOUT and STDERR redirection to null.
SaR 's|(1>\|>) /dev/null 2>&1|\&> /dev/null|g'

# Update the header's timestamp.
if Str=`grep -x '# Last Change\s\+- .*' "$CurFile"`; then
	printf -v CurDate "%(%a %_d %b %T %Z %Y)T" -1
	SaR "s/${Str#* - }$/$CurDate/"
fi

# Update the `CurVer` timestamp.
if Str=`grep "^CurVer='.*" "$CurFile"`; then
	printf -v CurDate "%(%F)T" -1
	SaR "s/$Str/CurVer='$CurDate'/"
fi

# Remove unnecessary `-r` from `read` in `Usage()`.
LineCount=0
while read F1 F2 F3 _; do
	let LineCount++

	[ "$F1" == 'Usage(){' ] && IsUsage='true'
	if [ "$IsUsage" == 'true' -a "$F1$F2$F3" == 'whileread-r;' ]; then
		SaR "${LineCount}s/while read -r/while read/"
		break
	fi
done < "$CurFile"

# Correct no-longer-valid GitHub URL.
SaR 's|(\$Domain/terminalforlife/)\$Progrm|\1Extra|g'

# No quoting variables when using `[[`.
SaR 's/\[\[ \"\$(.*)"/[[ $\1/g'

# Appriately quote booleans.
SaR "s/=\"([Tt][Rr][Uu][Ee])\"/='\\1'/g"
SaR "s/ \"([Tt][Rr][Uu][Ee])\" / '\\1' /g"
SaR "s/=\"([Ff][Aa][Ll][Ss][Ee])\"/='\\1'/g"
SaR "s/ \"([Ff][Aa][Ll][Ss][Ee])\" / '\\1' /g"

# Just in-case, albeit inaccurate, but integers are not strings.
SaR "s/=[\"']{1}([0-9]*)[\"']{1}/=\\1/g"
