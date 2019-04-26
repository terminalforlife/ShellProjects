#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - miscellaneous/update_links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Fri 26 Apr 14:35:03 BST 2019
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

/bin/rm -v $HOME/.config/compton.conf 2>&-
/bin/ln -v compton.conf $HOME/.config/ 2>&-

#/bin/rm -v $HOME/.keynavrc 2>&-
#/bin/ln -v .keynavrc $HOME/ 2>&-

/bin/rm -v $HOME/.config/dunst/dunstrc 2>&-
/bin/ln -v dunstrc $HOME/.config/dunst/ 2>&-

#/bin/rm -v $HOME/.config/tint2/tint2rc 2>&-
#/bin/ln -v tint2rc $HOME/.config/tint2/tint2rc 2>&-

#/bin/rm -v $HOME/.config/gpicview/gpicview.conf 2>&-
#/bin/ln -v gpicview.conf $HOME/.config/gpicview/gpicview.conf 2>&-

#/bin/rm -v $HOME/.config/pcmanfm/default/pcmanfm.conf 2>&-
#/bin/ln -v pcmanfm.conf $HOME/.config/pcmanfm/default/pcmanfm.conf 2>&-

/bin/rm -v $HOME/.config/xfce4/terminal/terminalrc 2>&-
/bin/ln -v terminalrc $HOME/.config/xfce4/terminal/terminalrc 2>&-

/bin/rm -v $HOME/.config/herbstluftwm/autostart 2>&-
/bin/ln -v autostart $HOME/.config/herbstluftwm/ 2>&-

/bin/rm -v $HOME/.config/herbstluftwm/panel.sh 2>&-
/bin/ln -v panel.sh $HOME/.config/herbstluftwm/ 2>&-

# vim: noexpandtab colorcolumn=84 tabstop=8 noswapfile nobackup
