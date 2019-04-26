#!/usr/bin/fish

#----------------------------------------------------------------------------------
# Project Name      - $HOME/.config/fish/config.fish
# Started On        - Thu 14 Sep 12:44:56 BST 2017
# Last Change       - Fri 26 Apr 14:38:20 BST 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------

if [ -d "$HOME/bin" ]; and [ "$PATH" != */home/"$USER"/bin* ]
	export PATH="/home/$USER/bin $PATH"
end

umask 0077

#----------------------------------------------------------------------------------

set HISTTIMEFORMAT [%F_%X]; set HISTSIZE 1000; set HISTFILESIZE 0

#----------------------------------------------------------------------------------

set FLIB "$HOME/.shplugs"

if [ -d "$FLIB" ]
	for FUNC in;
		Bell_Alarm Cleaner_RK_Scan Times_Table List_Signals NIR_Difference\
		Load_File_Links2 CPU_Intensive_Procs Git_Status_All;
		[ -f "$FLIB/$FUNC" ]; and source "$FLIB/$FUNC"
	end
end

#unset FLIB FUNC

#----------------------------------------------------------------------------------

export VBOX_USER_HOME="/media/$USER/1TB Internal HDD/Linux Generals/VirtualBox VMs"
export TIMEFORMAT=">>> real %3R | user %3U | sys %3S | pcpu %P <<<"
export LS_COLORS="di=1;31:ln=1;32:mh=00:ex=1;33:"
export TERM="xterm-256color"
export LESSSECURE=1
export COLUMNS
export LINES

if type -P /usr/bin/sudo >&- 2>&-
	if type -P /usr/bin/vim >&- 2>&-
		export SUDO_EDITOR="rvim"
	else if type -P /usr/bin/nano >&- 2>&-
		export SUDO_EDITOR="rnano"
	end
end

#----------------------------------------------------------------------------------

if type -P /bin/date /usr/bin/tty >&- 2>&-
	set TERMWATCH_LOGFILE "$HOME/.termwatch.log"
	set CURTERM `/usr/bin/tty`

	if [ -f "$TERMWATCH_LOGFILE" ]; and [ -w "$TERMWATCH_LOGFILE" ]
		echo "Using $CURTERM:-Unknown ($TERM-unknown)"\
			"at `/bin/date` as $USER." >> "$TERMWATCH_LOGFILE"
	end

	#unset TERMWATCH_LOGFILE CURTERM
end

#----------------------------------------------------------------------------------

set FISH_ALIASES "$HOME/.fish_aliases"
if [ -f "$FISH_ALIASES" ]; and [ -r "$FISH_ALIASES" ]
	source "$FISH_ALIASES"
end

#unset FISH_ALIASES
