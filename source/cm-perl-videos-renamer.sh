#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/source/cm-perl-videos-renamer.sh
# Started On        - Wed 15 Dec 08:08:38 GMT 2021
# Last Change       - Wed 15 Dec 08:42:56 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# A surprisingly lengthy and complex script (for what I needed to do) which
# renames a series of files for Code Maven's PERL videos, to sane and more
# consistent filenames.
#
# This allows for the proper ordering (per standard alphanumeric filename
# sorting) and (optional) capitalization of the words in titles. This makes for
# a more attractive and at the very least practical list of video files.
#
# NOTE: Nothing will actually happen unless you set `ListOnly` to 'False'.
#
# WARNING: This cannot be undone, unless you have some sort of database of
#          inodes and their original filenames on a suitable filesystem.
#------------------------------------------------------------------------------

# Set this to 'False' to allow files to actually be renamed.
ListOnly='Tre'

for File in *.mp4; {
	[ -f "$File" ] || continue

	Nr=${File#* - }
	Title=${Nr#* - }
	#Title=${Title^}
	Nr=${Nr%% - *}

	if ! [[ $Nr =~ ^[0-9]+\.[0-9]+$ ]]; then
		# Handle the exceptions, for files failing the above processing.
		Prefix=${File#Beginner Perl Maven tutorial }
		if [[ $Prefix =~ ^[-\ ]?([0-9]+\.[0-9]+)\  ]]; then
			Nr=${BASH_REMATCH[1]}
			Title=${Title#*-}
		else
			continue
		fi
	fi

	# Capitalize each space-delimited word and correct some words. This is
	# nice, but it can be a little strange, such as 'Int'. CM should have just
	# used better video titles. :P
	#NewTitle=
	#read -a Words <<< "$Title"
	#for Word in "${Words[@]}"; {
	#	# Account for text in parentheses and the like.
	#	FirstChar=${Word:0:1}
	#	case $FirstChar in
	#		[[:punct:]])
	#			Word=${Word#?}
	#			Word=$FirstChar${Word^} ;;
	#	esac

	#	Word=${Word^}

	#	# Correct certain words, like 'Regex' to 'REGEX'.
	#	Word=${Word//Regexes/REGEXs}
	#	Word=${Word//Regex/REGEX}
	#	Word=${Word//Perl/PERL}

	#	NewTitle+="${Word^} "
	#}

	[ -n "$NewTitle" ] && Title=${NewTitle% }

	printf -v NewFilename '%02d-%02d: %s' ${Nr%.*} ${Nr#*.} "$Title"
	if [ "$ListOnly" == 'True' ]; then
		printf '%s\n' "$NewFilename"

		# Use this instead, if you want to see the before and after.
		#printf '"\e[2;97m%s\e[0m" "\e[2;97m%s\e[0m"\n' "$File" "$NewFilename"
	elif [ "$ListOnly" == 'False' ]; then
		mv "$File" "$NewFilename"
	else
		printf 'Err: Variable `ListOnly` is invalid -- quitting\n' 1>&2
		exit 2
	fi
}
