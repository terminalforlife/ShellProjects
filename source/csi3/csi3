#!/usr/bin/env bash
#cito M:755 O:0 G:0 T:/usr/bin/csi3
#------------------------------------------------------------------------------
# Project Name      - Extra/source/csi3/csi3
# Started On        - Sat 29 May 22:47:07 BST 2021
# Last Change       - Wed 15 Dec 23:35:44 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# A simple pure-BASH solution for listing your key bindings to i3-wm/i3-gaps.
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
#   bash (>= 4.4.18-2)
#------------------------------------------------------------------------------

CurVer='2021-12-15'
Progrm='csi3'

Usage(){
	while read; do
		printf '%s\n' "$REPLY"
	done <<-EOF
		Usage: $Progrm [OPTS] [FILE]

		  -h, --help               - Display this help information.
		  -v, --version            - Output the version datestamp.
		  -C, --nocolor            - Disable ANSI color escape sequences.
		  -E, --noexecs            - Omit 'exec' & 'exec_always' bindings.
		  -e, --execs              - Show only 'exec' & 'exec_always' bindings.
		  -o, --override           - Override the default FILE locations.

		A key binding's action being prepended with an exclamation mark ('!')
		indicates it's a shell command, and not a native i3-wm command.

		If a \$mod (case-insensitive) variable is set for the primary modifier
		key, in the i3 configuration file, it should be correctly parsed. Other
		variables will not be parsed.

		Modes are not handled.
	EOF
}

Err(){
	printf 'Err: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

Red='\e[91m'
Grey='\e[37m'
Reset='\e[0m'

while [ -n "$1" ]; do
	case $1 in
		--help|-h|-\?)
			Usage; exit 0 ;;
		--version|-v)
			printf '%s\n' "$CurVer"; exit 0 ;;
		--nocolor|-C)
			Red=
			Grey=
			Reset= ;;
		--noexecs|-E)
			NoExecsFlag=$1
			NoExecs='True' ;;
		--execs|-e)
			ExecsFlag=$1
			Execs='True' ;;
		--override|-o)
			Override='True' ;;
		-*)
			Err 1 'Incorrect option(s) specified.' ;;
		*)
			break ;;
	esac
	shift
done

if [ "$Execs" == 'True' -a "$NoExecs" == 'True' ]; then
	Err 1 "OPTs '$NoExecsFlag' & '$ExecsFlag' are incompatible."
fi

#----------------------------------------Confirm Suitable File Found & Readable

[ -n "$1" ] && File+=("$1")

if [ "$Override" != 'True' ]; then
	Places=(
		"$HOME/.config/i3/config"
		"$HOME/.i3/config"
	)
fi

for Place in "${Places[@]}"; {
	if [ -f "$Place" ]; then
		if [ -r "$Place" ]; then
			File=$Place
			break
		else
			Err 1 "File '$Place' unreadable."
		fi
	fi
}

[ -z "$File" ] && Err 1 'Unable to find a suitable configuration file.'

#-------------------------------------------------------------------Gather Data

# Capitalize the first character of each word. Intended to be used with
# separate arguments -- ideally a quoted array. This will create a trailing '+'
# which should be removed with Parameter Expansion before being used.
Capitalize() { printf '%s+' "${@^}"; }

Count=0
KeysLenMax=0
while read Line; do
	CurrentKey=

	case $Line in
		'set $'[Mm][Oo][Dd]*)
			ModVar=${Line#set }
			ModVar=${ModVar% *}
			ModKey=${Line#set \$* } ;;
		bindsym\ *)
			read _ Keys Action <<< "$Line"

			# Capitalize the first character of each key.
			Keys=`Capitalize ${Keys//+/ }`
			Keys=${Keys%+}

			if [ "$NoExecs" == 'True' ]; then
				case $Action in
					exec\ *|exec_always\ *)
						continue ;;
				esac
			elif [ "$Execs" == 'True' ]; then
				case $Action in
					exec\ *|exec_always\ *)
						;;
					*)
						continue ;;
				esac
			fi

			Action=${Action/exec --no-startup-id /!}
			Action=${Action/exec_always --no-startup-id /!}
			Action=${Action/exec_always /!}
			Action=${Action/exec /!}

			KeysLen=${#Keys}
			if [ $KeysLen -gt $KeysLenMax ]; then
				KeysLenMax=$KeysLen
			fi

			let Count++

			# Using the `$Count` variable in order to maintain the original
			# order, otherwise BASH will butcher the order, unfortunately.
			declare -A Bindings["${Count}_$Keys"]=$Action ;;
	esac
done < "$File"

#----------------Display Results, Using `$Count` to Maintain the Original Order

Count=1
until [ $Count -gt ${#Bindings[@]} ]; do
	for Binding in "${!Bindings[@]}"; {
		if [ $Count -eq "${Binding%%_*}" ]; then
			printf '%*s ' $KeysLenMax "${Binding#*_}"
			if [[ ${Bindings[$Binding]} == \!* ]]; then
				printf "$Red!\e[37m%s$Reset\n" "${Bindings[$Binding]#!}"
			else
				printf "$Grey%s$Reset\n" "${Bindings[$Binding]}"
			fi

			let Count++

			break
		fi
	}
done
