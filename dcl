#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - miscellaneous/dcl (dos-cdrom-lib)
# Started On        - Thu 23 Nov 16:47:50 GMT 2017
# Last Change       - Thu 23 Nov 22:16:08 GMT 2017
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Placeholder for upcoming project.
#----------------------------------------------------------------------------------

XERR(){ printf "[L%0.4d] ERROR: %s\n" "$1" "$2" 1>&2; exit 1; }
ERR(){ printf "[L%0.4d] ERROR: %s\n" "$1" "$2" 1>&2; }

declare -i DEPCOUNT=0
for DEP in /bin/{sleep,mkdir} /usr/bin/{tput,wget}; {
	[ -x "$DEP" ] || {
		ERR "$LINENO" "Dependency '$DEP' not met."
		DEPCOUNT+=1
	}
}

[ $DEPCOUNT -eq 0 ] || exit 1

USAGE(){
	while read -r; do
		printf "%s\n" "$REPLY"
	done <<-EOF
		            DCL (DOS-CDROM-LIB) (23rd November 2017)
		            Written by terminalforlife (terminalforlife@yahoo.com)
		
		            Description Here

		SYNTAX:     dcl [OPTS]
		
		OPTS:       --help|-h|-?            - Displays this help information.
		            --debug|-D              - Enables the built-in bash debugging.
		            --quiet|-q              - Runs in quiet mode. Errors still output.
	EOF
}

while [ -n "$1" ]; do
	case "$1" in
		--help|-h|-\?)
			USAGE; exit 0 ;;
		--debug|-D)
			DEBUGME="true" ;;
		--quiet|-q)
			BEQUIET="true" ;;
		*)
			XERR "$LINENO" "Incorrect argument(s) specified." ;;
	esac

	shift
done

[ $UID -eq 0 ] && XERR "$LINENO" "Root access isn't required."

[ "$BEQUIET" == "true" ] && exec 1> /dev/null
[ "$DEBUGME" == "true" ] && set -xeu

MAINDIR="$HOME/.config/dcl"
[ -d "$MAINDIR" ] || /bin/mkdir -p "$MAINDIR"

CACHEDIR="$MAINDIR/cache"
[ -d "$CACHEDIR" ] || /bin/mkdir "$CACHEDIR"

DOMAIN="https://archive.org"
URL="/details/cdromsoftware"
AND1="?and[]=languageSorter%3A%22English%22"
AND2="&and[]=mediatype%3A%22software%22"
AND3="&and[]=subject%3A%22MS-DOS+CD-ROM%22&sort="
CATLNK="$DOMAIN$URL$AND1$AND2$AND3"

PRESS_TO_CONTINUE(){
	printf "\n  Press any key to continue... "
	read -esn 1; printf "\ec"
}

ERR(){
	printf "\n  ERROR: %s\n" "$1"
	PRESS_TO_CONTINUE
}

#----------------------------------------------------------------------MENU OPTIONS

SELECT_OPTION_ONE(){
	while :; do
		/usr/bin/tput clear

		while read -r; do
			printf "%s\n" "$REPLY"
		done <<-EOF
		
			         ╭ Explore the Pages ╮
			         ┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
		
			  Enter a menu option at the prompt.
		
			  1) Select Page Number
			  2) Back to the Main Menu
		
		EOF

		if ! [ -f "$CACHEDIR/P0001" ]; then
			/usr/bin/wget -q "${CATLNK}&page=1" -O "$CACHEDIR/P0001"
		fi

		read -en 1 -p "  ▸ "

		case "$REPLY" in
			1)
				;;
			2)
				break ;;
			*)
				ERR "Invalid option selected." ;;
		esac

		sleep 0.001
	done
}

SELECT_OPTION_TWO(){
	/usr/bin/tput clear


}

SELECT_OPTION_THREE(){
	/usr/bin/tput clear


}

/usr/bin/tput smcup
#------------------------------------------------------------------------------MAIN

while :; do
	while read -r; do
		printf "%s\n" "$REPLY"
	done <<-EOF
	
		         ╭ Welcome to DCL ╮
		         ┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
	
		  Enter a menu option at the prompt.
	
		  1) Explore the Pages
		  2) Change Settings
		  3) Help & Support
		  4) Quit DCL
	
	EOF

	read -en 1 -p "  ▸ "

	case "$REPLY" in
		1)
			SELECT_OPTION_ONE
			/usr/bin/tput clear ;;
		2)
			SELECT_OPTION_TWO
			/usr/bin/tput clear ;;
		3)
			SELECT_OPTION_THREE
			/usr/bin/tput clear ;;
		4)
			/usr/bin/tput clear
			break ;;
		*)
			ERR "Invalid option selected." ;;
	esac

	sleep 0.001
done

#------------------------------------------------------------------------------DONE
/usr/bin/tput rmcup
