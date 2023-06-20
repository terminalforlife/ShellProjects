#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - ShellProjects/devutils/buildpkg.sh
# Started On        - Sat 23 Nov 00:28:26 GMT 2019
# Last Change       - Tue 20 Jun 20:28:30 BST 2023
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Developer script for quick package building, used in DEB-Packages. Made for
# me, so use at your own peril, unless of course you're in the same situation.
#
# Assumptions:
#
#   * You only want shell programs which must use bash or have bash-supported
#     syntax, allowing for the `-v` flag to output only the version: YYYY-MM-DD
#
#   * You require everything within the build package to be 0:0, but have 644
#     for files and 755 for directories. Except:
#
#   * Your `ProgName` is the executable and therefore meant for `/usr/bin/`, -
#     thus demanding the standard of 755 permissions (plus previously-set 0:0).
#
#   * You will make the needed changes to the below variables for your needs.
#
#   * You already have a directory kept in `BuildStore` for safe-keeping and
#     wish to re-use it as a template for the next build, with each build
#     directory having the name of `BuildConv`.
#
#   * You want the directory this script uses to be `WorkDir`, in which
#     `BuildConv` will be created (destination of aforementioned copy).
#
#   * Your editor is set globally with the `EDITOR` environment variable, -
#     unless you set this yourself, below. The default is `vim`, and you're OK
#     with that.
#------------------------------------------------------------------------------

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

BuildStore="$HOME/Documents/TT"
GitHub="$HOME/GitHub/terminalforlife/Personal/ShellProjects/source"
ProgName=$1

[ $# -eq 0 ] && Err 1 "Argument '\$1' must be the '\$ProgName'."

PKGName="${ProgName}_${Version}_all.deb"
BuildConv="pkg-debian ($ProgName)"
WorkDir="$HOME/Desktop"
EDITOR=${EDITOR:-vim}

# The build version of the program above.
if [ -n "$2" ]; then
	case $2 in
		[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])
			Version=$2 ;;
		''|*)
			Err 1 "Invalid '\$Version' string in argument '\$2'." ;;
	esac
else
	GetHead=`head -n 1 "$GitHub/$ProgName"`
	case $GetHead in
		'#!/usr/bin/env bash'|'#!/bin/bash')
			Version=`bash "$GitHub/$ProgName" -v` ;;
		'#!/usr/bin/env sh'|'#!/bin/sh')
			Version=`sh "$GitHub/$ProgName" -v` ;;
		*)
			Err 1 "Unable to parse the '$ProgName' shebang." ;;
	esac
fi

if [ `id -u` -ne 0 ]; then
	Err 1 "Permission denied -- are you 'root'?"
elif ! [ -d "$BuildStore" ]; then
	Err 1 "Build store directory '`basename "$BuildStore"`' not found."
elif ! [ -r "$BuildStore" ] || ! [ -w "$BuildStore" ] || ! [ -x "$BuildStore" ]; then
	Err 1 "Build store directory '`basename "$BuildStore"`' inaccessible."
elif ! [ $# -eq 1 -o $# -eq 2 ]; then
	Err 1 "Usage: buildpkg.sh [ProgName] [Version]"
fi

if [ -d "$BuildStore/$BuildConv" ]; then
	printf "Copying over old directory from build store...\n"
	if ! cp -r "$BuildStore/$BuildConv" "$WorkDir/" 1> /dev/null; then
		Err 1 "Directory from build store failed to copy over."
	fi
else
	# Currently, this script allows only for 're'-building packages.
	Err 1 "Desired directory (per the naming convention) not found."
fi

printf "Setting directories and files to '0:0'...\n"
if ! find "$WorkDir/$BuildConv" -exec chown 0:0 {} \+ 1> /dev/null; then
	Err 1 "Group and ownership alterations failed."
fi

printf "Setting mode of files to '644'...\n"
if ! find "$WorkDir/$BuildConv" -type f -exec chmod 644 {} \+ 1> /dev/null; then
	Err 1 "Mode alterations of files failed."
fi

printf "Setting mode of '$ProgName' executable to 755...\n"
if ! chmod 755 "$WorkDir/$BuildConv/usr/bin/$ProgName" 1> /dev/null; then
	Err 1 "Mode alterations of '$ProgName' failed."
fi

printf "Setting mode of directories to '755'...\n"
if ! find "$WorkDir/$BuildConv" -type d -exec chmod 755 {} \+ 1> /dev/null; then
	Err 1 "Mode alterations of directories failed."
fi

printf "Updating build '$ProgName' to new version...\n"
if ! cp "$GitHub/$ProgName" "$WorkDir/$BuildConv/usr/bin/$ProgName"; then
	Err 1 "Failed to update '$ProgName' in working directory."
else
	OldVersion=`bash "$BuildStore/$BuildConv/usr/bin/$ProgName" -v`
	if [ "$OldVersion" = $Version ]; then
		printf "Fetching last modification time...\n"
		printf "Old: %s\n" "$(stat --printf='%y' "$BuildStore/$BuildConv/usr/bin/$ProgName")"
		printf "New: %s\n" "$(stat --printf='%y' "$WorkDir/$BuildConv/usr/bin/$ProgName")"
	fi

	printf "Updated from '${OldVersion:-N/A}' to '${Version:-N/A}'.\n"
fi

(
	cd "$GitHub"
	md5sum "$ProgName" > "$WorkDir/$BuildConv/DEBIAN/md5sums"
)

printf "Beginning work on 'DEBIAN/control' file...\n"
printf "[O]pen or [j]ust update version string: "
read OpenEditor

case $OpenEditor in
	[Oo]|[Oo][Pp][Ee][Nn])
		if ! $EDITOR "$WorkDir/$BuildConv/DEBIAN/control"; then
			Err 1 "Editing 'control' with '$EDITOR' failed."
		fi ;;
	[Jj]|[Jj][Uu][Ss][Tt])
		REGEX='^Version: [0-9]{4}-[0-9]{2}-[0-9]{2}$'
		if ! sed -ir "s/$REGEX/$Version/" "$WorkDir/$BuildConv/DEBIAN/control"; then
			Err 1 "Updating 'control' key 'Version' with 'sed' failed."
		fi ;;
	''|*)
		Err 1 'Unrecognised or null response detected.' ;;
esac
