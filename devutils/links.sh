#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Fri 31 Jan 02:47:34 GMT 2020
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Just a simple, quick script to update the hard links when changing branches.
#------------------------------------------------------------------------------

set -e
. /usr/lib/tflbp-sh/ChkDep
set +e

ChkDep ln rm

{
	cd "$HOME/GitHub/terminalforlife/Personal/Extra"

	if command -v compton 1> /dev/null; then
		rm -v $HOME/.config/compton.conf
		ln -v misc/compton.conf $HOME/.config/
	fi

	if command -v keynav 1> /dev/null; then
		rm -v $HOME/.keynavrc
		ln -v misc/.keynavrc $HOME/
	fi

	if command -v dunst 1> /dev/null; then
		rm -v $HOME/.config/dunst/dunstrc
		ln -v misc/dunstrc $HOME/.config/dunst/
	fi

	if command -v xfce4-terminal 1> /dev/null; then
		rm -v $HOME/.config/xfce4/terminal/terminalrc
		ln -v misc/terminalrc $HOME/.config/xfce4/terminal/terminalrc
	fi

	if command -v herbsluftwm 1> /dev/null; then
		rm -v $HOME/.config/herbstluftwm/autostart
		ln -v misc/autostart $HOME/.config/herbstluftwm/
	fi
} 2> /dev/null
