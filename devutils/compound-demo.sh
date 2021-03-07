#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/compound-demo.sh
# Started On        - Sun  7 Mar 22:26:18 GMT 2021
# Last Change       - Sun  7 Mar 22:53:39 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# For all these years, there's been a big caveat to my programs, and that's the
# inability to use compounded short-form arguments, such as `-this` being equal
# to `-t`, `-h`, `-i`, and `-s`.
#
# However, with this code, I've demonstrated how it can work, at least in BASH.
# In Perl, I'd do something similar, but certainly much cleaner.
#
# The downside, is that I'd have to use functions or something for each
# argument with a long and short form; this would add complexity and add a lot
# more code, but it'd work!
#
# Another problem with this approach, is that it messes up the order in which
# the user provides the arguments to the script; it's probably not a huge deal
# but it could really put a spanner in the works of some programs.
#
# One workaround for the need for multiple additional functions, would be to
# use just the one additional function whose arguments can be provided as the
# arguments to the actual script.
#
# Honestly, I'd probably resort to `getopts` before I used this approach.
#------------------------------------------------------------------------------

# Uncomment the below lines for an easy demonstration.
#printf 'ARGS: --this --is -ate --st\n'
#set -- --this --is -ate --st

CurVer='2021-03-07'
Progrm=${0##*/}

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

ArgUsage() {
	while read; do
		printf '%s\n' "$REPLY"
	done <<-EOF
		Usage: $Progrm [OPTS]

		  -h, --help               - Display this help information.
		  -v, --version            - Output the version datestamp.
		  --is                     - ???
		  --st                     - ???
		  --this                   - ???
		  -a                       - ???
		  -e                       - ???
		  -t, --test               - ???
	EOF

	exit 0
}

ArgVersion() {
	printf '%s\n' "$CurVer"
	exit 0
}

ArgTest() {
	printf "Found the '--test|-t' flag.\n"
}

# First, process the long-form arguments.
while [ "$1" ]; do
	case $1 in
		--help)
			ArgUsage ;;
		--version)
			ArgVersion ;;
		--this)
			printf 'Found: --this\n' ;;
		--is)
			printf 'Found: --is\n' ;;
		--st)
			printf 'Found: --st\n' ;;
		--test)
			ArgTest ;;
		-[!-]*)
			# If a series of short-form arguments, are found, parse them, then
			# store them into a separate array which can be processed later.
			#
			# The downside, is that the last short-form argument doesn't allow
			# the use of an argument, but it could be incorporated using an
			# additional `shift` call based on what the last short argument is.
			for Char in `eval printf '%d\\\n' {1..${#1}}`; {
				Short="-${1:$Char:1}"
				if [ "$Short" == '-' ]; then
					continue
				else
					Shorts+=("$Short")
				fi
			} ;;
		--*)
			Err 1 'Invalid option(s) specified.' ;;
	esac
	shift
done

# Yet another downside to this block being separate from the above, is that if
# duplicates are provided, you'll wind up re-executing the code via the called
# function. Run `$0 -te -t` to see what I mean.
#
# This could be addressed by using a variable, but it'd be yet more complexity
# and inconvenience.
for Arg in "${Shorts[@]}"; do
	case $Arg in
		-h)
			ArgUsage ;;
		-v)
			ArgVersion ;;
		-a)
			printf 'Found: -a\n' ;;
		-t)
			ArgTest ;;
		-e)
			printf 'Found: -e\n' ;;
		-*)
			Err 1 'Invalid option(s) specified.' ;;
	esac
done
