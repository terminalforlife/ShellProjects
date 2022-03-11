#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Fri 11 Mar 18:06:54 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Just a simple, quick script to update the hard links when changing branches.
#------------------------------------------------------------------------------

exec 2> /dev/null

if cd "$HOME/GitHub/terminalforlife/Personal/Extra"; then
	mkdir -pv "$HOME/.config"

	if command -v alacritty 1> /dev/null; then
		mkdir -pv "$HOME/.config/alacritty"
		ln -fv misc/alacritty.yml $HOME/.config/
	fi

	if command -v compton 1> /dev/null; then
		ln -fv misc/compton.conf $HOME/.config/
	fi

	if command -v keynav 1> /dev/null; then
		ln -fv misc/.keynavrc $HOME/
	fi

	if command -v dunst 1> /dev/null; then
		mkdir -pv "$HOME/.config/dunst"
		ln -fv misc/dunstrc $HOME/.config/dunst/
	fi

	if command -v xfce4-terminal 1> /dev/null; then
		mkdir -pv "$HOME/.config/xfce4/terminal"
		ln -fv misc/terminalrc $HOME/.config/xfce4/terminal/terminalrc
	fi

	if command -v herbsluftwm 1> /dev/null; then
		mkdir -pv "$HOME/.config/herbstluftwm"
		ln -fv misc/autostart $HOME/.config/herbstluftwm/
	fi
fi
