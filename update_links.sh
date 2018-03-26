#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - miscellaneous/update_links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Mon 26 Mar 21:56:42 BST 2018
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

/bin/rm -v $HOME/.config/compton.conf 2> /dev/null
/bin/ln -v compton.conf $HOME/.config/ 2> /dev/null

#/bin/rm -v $HOME/.keynavrc 2> /dev/null
#/bin/ln -v .keynavrc $HOME/ 2> /dev/null

/bin/rm -v $HOME/.config/dunst/dunstrc 2> /dev/null
/bin/ln -v dunstrc $HOME/.config/dunst/ 2> /dev/null

#/bin/rm -v $HOME/.config/tint2/tint2rc 2> /dev/null
#/bin/ln -v tint2rc $HOME/.config/tint2/tint2rc 2> /dev/null

#/bin/rm -v $HOME/.config/gpicview/gpicview.conf 2> /dev/null
#/bin/ln -v gpicview.conf $HOME/.config/gpicview/gpicview.conf 2> /dev/null

#/bin/rm -v $HOME/.config/pcmanfm/default/pcmanfm.conf 2> /dev/null
#/bin/ln -v pcmanfm.conf $HOME/.config/pcmanfm/default/pcmanfm.conf 2> /dev/null

/bin/rm -v $HOME/.config/xfce4/terminal/terminalrc 2> /dev/null
/bin/ln -v terminalrc $HOME/.config/xfce4/terminal/terminalrc 2> /dev/null

# vim: noexpandtab colorcolumn=84 tabstop=8 noswapfile nobackup
