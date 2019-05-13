#!/usr/bin/env bash

#----------------------------------------------------------------------------------
# Project Name      - Extra/update_links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Mon 13 May 01:39:31 BST 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Just a simple, quick script to update the hard links when changing branches.
#------------------------------------------------------------------------------MAIN

FAIL(){
	printf "[L%0.4d] ERROR: %s\n" "$2" "$3" 1>&2
	[ $1 -eq 1 ] && exit 1
}

declare -i DEPCOUNT=0
for DEP in ln rm; {
	if ! type -fP "$DEP" > /dev/null 2>&1; then
		FAIL 0 "$LINENO" "Dependency '$DEP' not met."
		DEPCOUNT+=1
	fi
}

[ $DEPCOUNT -eq 0 ] || exit 1

if [ "${PWD//*\/}" != "Extra" ]; then
	FAIL 1 "$LINENO" "Not in the repository's root directory."
else
	rm -v $HOME/.config/compton.conf 2>&-
	ln -v compton.conf $HOME/.config/ 2>&-

	#rm -v $HOME/.keynavrc 2>&-
	#ln -v .keynavrc $HOME/ 2>&-

	rm -v $HOME/.config/dunst/dunstrc 2>&-
	ln -v dunstrc $HOME/.config/dunst/ 2>&-

	#rm -v $HOME/.config/tint2/tint2rc 2>&-
	#ln -v tint2rc $HOME/.config/tint2/tint2rc 2>&-

	#rm -v $HOME/.config/gpicview/gpicview.conf 2>&-
	#ln -v gpicview.conf $HOME/.config/gpicview/gpicview.conf 2>&-

	#rm -v $HOME/.config/pcmanfm/default/pcmanfm.conf 2>&-
	#ln -v pcmanfm.conf $HOME/.config/pcmanfm/default/pcmanfm.conf 2>&-

	rm -v $HOME/.config/xfce4/terminal/terminalrc 2>&-
	ln -v terminalrc $HOME/.config/xfce4/terminal/terminalrc 2>&-

	rm -v $HOME/.config/herbstluftwm/autostart 2>&-
	ln -v autostart $HOME/.config/herbstluftwm/ 2>&-

	rm -v $HOME/.config/herbstluftwm/panel.sh 2>&-
	ln -v panel.sh $HOME/.config/herbstluftwm/ 2>&-
fi

# vim: noexpandtab colorcolumn=84 tabstop=8 noswapfile nobackup
