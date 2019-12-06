#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/devutils/update_links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Fri  6 Dec 03:47:20 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Just a simple, quick script to update the hard links when changing branches.
#------------------------------------------------------------------------------MAIN

. /usr/lib/tflbp-sh/ChkDep

ChkDep ln rm

{
	cd "$HOME/GitHub/terminalforlife/Personal/Extra"

	rm -v $HOME/.config/compton.conf
	ln -v misc/compton.conf $HOME/.config/

	rm -v $HOME/.keynavrc
	ln -v misc/.keynavrc $HOME/

	rm -v $HOME/.config/dunst/dunstrc
	ln -v misc/dunstrc $HOME/.config/dunst/

	rm -v $HOME/.config/xfce4/terminal/terminalrc
	ln -v misc/terminalrc $HOME/.config/xfce4/terminal/terminalrc

	rm -v $HOME/.config/herbstluftwm/autostart
	ln -v misc/autostart $HOME/.config/herbstluftwm/

	rm -v $HOME/.config/herbstluftwm/panel.sh
	ln -v misc/panel.sh $HOME/.config/herbstluftwm/
} 2> /dev/null
