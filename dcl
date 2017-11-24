#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - miscellaneous/dcl (dos-cdrom-lib)
# Started On        - Thu 23 Nov 16:47:50 GMT 2017
# Last Change       - Fri 24 Nov 03:18:02 GMT 2017
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Work in progress. An interactive shell program to browse and download files.
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

		            Interactively browse and download MS-DOS optical media.

		SYNTAX:     dcl [OPTS]

		OPTS:       --help|-h|-?            - Displays this help information.
		            --debug|-D              - Enables the built-in bash debugging.

		NOTE:       Entries are unfortunately not guaranteed to be applicable, per whatever
		            is available on the website which dcl heavily parses.
	EOF
}

while [ -n "$1" ]; do
	case "$1" in
		--help|-h|-\?)
			USAGE; exit 0 ;;
		--debug|-D)
			DEBUGME="true" ;;
		*)
			XERR "$LINENO" "Incorrect argument(s) specified." ;;
	esac

	shift
done

[ $UID -eq 0 ] && XERR "$LINENO" "Root access isn't required."

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
CATL="$DOMAIN$URL$AND1$AND2$AND3"

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
	SHOW_PAGE(){
		if ! [ -f "$CACHEDIR/Page_${1}" ]; then
			/usr/bin/wget -q "${CATL}&page=$1"\
				-O "$CACHEDIR/Page_${1}"
		fi

		declare -i COUNT=0
		while read X; do
			if [[ "$X" =~ title=\".*\" ]]; then
				[ $COUNT -eq 10 ] && break || COUNT+=1
				IFS="\"" read -a Y <<< "$X"
				printf -v NAME "%s\n" "${Y[3]}"
				#TODO - Finish this.
			fi
		done < "$CACHEDIR/Page_${1}"

		PRESS_TO_CONTINUE
	}

	while :; do
		/usr/bin/tput clear

		while read -r; do
			printf "%s\n" "$REPLY"
		done <<-EOF
		
			         ╭ Explore the Pages ╮
			         ┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
		
			  Enter a menu option at the prompt.
		
			  1) View Page Number 1
			  2) View Page Number 2
			  3) View Page Number 3
			  4) View Page Number 4
			  5) Back to the Main Menu
		
		EOF

		read -en 1 -p "  ▸ "

		case "$REPLY" in
			1)
				SHOW_PAGE 1 ;;
			2)
				SHOW_PAGE 2 ;;
			3)
				SHOW_PAGE 3 ;;
			4)
				SHOW_PAGE 4 ;;
			5)
				break ;;
			*)
				ERR "Invalid option selected." ;;
		esac

		/bin/sleep 0.01
	done
}

SELECT_OPTION_TWO(){
	while :; do
		/usr/bin/tput clear

		while read -r; do
			printf "%s\n" "$REPLY"
		done <<-EOF
		
			         ╭ Change Settings ╮
			         ┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
		
			  Enter a menu option at the prompt.
		
			  1) ???
			  2) Back to the Main Menu
		
		EOF

		read -en 1 -p "  ▸ "

		case "$REPLY" in
			1)
				;;
			2)
				break ;;
			*)
				ERR "Invalid option selected." ;;
		esac

		/bin/sleep 0.01
	done
}

SELECT_OPTION_THREE(){
	while :; do
		/usr/bin/tput clear

		while read -r; do
			printf "%s\n" "$REPLY"
		done <<-EOF
		
			         ╭ Help & Support ╮
			         ┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
		
			  Enter a menu option at the prompt.
		
			  1) ???
			  2) Back to the Main Menu
		
		EOF

		read -en 1 -p "  ▸ "

		case "$REPLY" in
			1)
				;;
			2)
				break ;;
			*)
				ERR "Invalid option selected." ;;
		esac

		/bin/sleep 0.01
	done
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

	/bin/sleep 0.01
done

#------------------------------------------------------------------------------DONE
/usr/bin/tput rmcup
