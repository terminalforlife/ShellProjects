#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - miscellaneous/update_links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Thu  9 Nov 00:56:33 GMT 2017
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------

# Just a simple, quick script to update the hard links when changing branches.

#------------------------------------------------------------------------------MAIN

XERR(){ printf "[L%0.4d] ERROR: %s\n" "$1" "$2" 1>&2; exit 1; }
ERR(){ printf "[L%0.4d] ERROR: %s\n" "$1" "$2" 1>&2; }

declare -i DEPCOUNT=0
for DEP in /bin/{ln,rm}; {
	[ -x "$DEP" ] || {
		ERR "$LINENO" "Dependency '$DEP' not met."
		DEPCOUNT+=1
	}
}

[ $DEPCOUNT -eq 0 ] || exit 1

[ "${PWD//*\/}" == "miscellaneous" ] || {
	XERR "$LINENO" "Not in the repository's root directory."
}

/bin/rm $HOME/.config/compton.conf 2> /dev/null
/bin/ln compton.conf $HOME/.config/ 2> /dev/null

/bin/rm $HOME/.keynavrc 2> /dev/null
/bin/ln .keynavrc $HOME/ 2> /dev/null

/bin/rm $HOME/.vim/colors/tfl.vim 2> /dev/null
/bin/ln tfl.vim $HOME/.vim/colors/ 2> /dev/null

/bin/rm $HOME/.vimrc 2> /dev/null
/bin/ln .vimrc $HOME/ 2> /dev/null

/bin/rm $HOME/.config/dunst/dunstrc 2> /dev/null
/bin/ln dunstrc $HOME/.config/dunst/ 2> /dev/null
