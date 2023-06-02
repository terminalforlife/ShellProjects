#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - Extra/devutils/compound-demo.sh
# Started On        - Sun  7 Mar 22:26:18 GMT 2021
# Last Change       - Fri  2 Jun 18:01:37 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# As of 2023-06-02, I annoyingly easily conjured up this far more concise and
# practical solution to my very old previous approach. This looks to be so good
# that I will probably implement it into all of my BASH projects. This sort of
# approach would never have occurred to me a couple of years ago.
#
# These example flags are taken (neutered) from CSi3.
#------------------------------------------------------------------------------

Args=()
while [[ -n $1 ]]; do
	case $1 in
		-[^-]*)
			Str=${1#-}
			Len=${#Str}
			for (( Index = 0; Index < Len; Index++ )); {
				Char=${Str:Index:1}
				Args+=(-"$Char")
			} ;;
		*)
			Args+=("$1") ;;
	esac
	shift
done

set -- "${Args[@]}"

while [[ -n $1 ]]; do
	case $1 in
		--help|-h|-\?)
			printf '%s\n' "$1" ;;
		--version|-v)
			printf '%s\n' "$1" ;;
		--nocolor|-C)
			printf '%s\n' "$1" ;;
		--noexecs|-E)
			printf '%s\n' "$1" ;;
		--ignore-vars|-V)
			printf '%s\n' "$1" ;;
		--execs|-e)
			printf '%s\n' "$1" ;;
		--key|-k)
			printf '%s\n' "$1" ;;
		--file|-f)
			printf '%s\n' "$1" ;;
		--number|-n)
			printf '%s\n' "$1" ;;
		-)
			printf '%s\n' "$1" ;;
		*)
			printf 'Err: Incorrect argument(s) specified.\n' 1>&2
			exit 1 ;;
	esac
	shift
done
