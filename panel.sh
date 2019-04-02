#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - $HOME/.config/herbstluftwm/panel.sh
# Started On        - Tue  2 Apr 12:14:00 BST 2019
# Last Change       - Tue  2 Apr 15:49:31 BST 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Written for Debian- and Ubuntu-based systems.
#
# This requires the 'libi3barview' function library file found within the i3config
# repository on my GitHub page, the link to which is shown above.
#
# The dzen2 package is required.
#----------------------------------------------------------------------------------

# Check an instance of dzen2 isn't already running, and if it is, kill it.
if [ `pidof dzen2 2> /dev/null` -gt 0 ]; then
	killall dzen2 || exit 1
	sleep 1s
fi

if [ -x /usr/bin/dzen2 ]; then
	FLIB(){ /bin/bash $HOME/.libi3bview $1 | /usr/bin/tr -d "\n"; }
	SPACER(){ printf "       "; }

	{
		while :; do
			printf 'INPUT="%s"' "`FLIB input_volume_pacmd`"
			SPACER
			printf 'OUTPUT="%s"' "`FLIB output_volume_pacmd`"
			SPACER
			printf 'MOC="%s"' "`FLIB mocp_info`"
			SPACER
			printf 'REDSHIFT="%s"' "`FLIB redshifter_value`"
			SPACER
			printf 'TCP_L/E="%s"' "`FLIB listening_estab_tcp_count`"
			SPACER
			printf 'UP="%s"' "`FLIB session_ul_total`"
			SPACER
			printf 'DOWN="%s"' "`FLIB session_dl_total`"
			SPACER
			printf 'ROOT="%s"' "`FLIB root_space_used_mb`"
			SPACER
			printf 'HOME="%s"' "`FLIB home_space_used_mb`"
			SPACER
			printf 'RAM="%s"' "`FLIB ram_used_mb`"
			SPACER
			printf 'USB="%d"' "`FLIB usb_count`"
			SPACER
			printf 'MOUNT="%d"' "`FLIB mount_count`"
			SPACER
			printf 'CPU="%s"' "`FLIB cpu_temp_alt`"
			SPACER
			printf 'DATE="%s"' "`FLIB show_date_time`"

			printf "\n"
			/bin/sleep 0.1s
			# Lengthen the refresh rate to improve performance.
		done 2> /dev/null
	} | /usr/bin/dzen2 -x 0 -w 1950 -h 16 -bg "#000000" -fg "#ffffff" -ta c\
		-fn "-misc-fixed-bold-r-normal--11-10-75-75-c-50-iso8859-1" &

	sleep 0.3s

	if [ -x /usr/bin/transset ]; then
		/usr/bin/transset 0.6 -i `/usr/bin/xwininfo -root -all\
			| /bin/grep dzen2 | /usr/bin/cut -d " " -f 6`
	fi
fi
