#!/bin/sh

#----------------------------------------------------------------------------------
# Project Name      - Extra/devutils/buildpkg.sh
# Started On        - Sat 23 Nov 00:28:26 GMT 2019
# Last Change       - Mon  9 Dec 18:46:17 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Developer script for quick package building, used in DEB-Packages. Made for me, -
# so use at your own peril, unless of course you have the same situation as I!
#
# Assumptions:
#
#   * You only want shell prorams which must use bash or have bash-supported
#     syntax, allowing for the `-v` flag to output only the version: YYYY-MM-DD
#
#   * You require everything within the build package to be 0:0, but have 644 for
#     files and 755 for directories. Except:
#
#   * Your `ProgName` is the executable and therefore meant for `/usr/bin/`, thus
#     demanding the standard of 755 permissions (plus previously-set 0:0).
#
#   * You are capable of mindfully editing the below variables for your use-case.
#
#   * You already have a directory kept in `BuildStore` for safe-keeping and wish
#     to re-use it as a template for the next build, with each build directory
#     having the name of `BuildConv`.
#
#   * You want the directory this script uses to be `WorkDir`, in which `BuildConv`
#     will be created (destination of aforementioned copy).
#
#   * Your editor is set globally with the `EDITOR` environment variable, unless
#     you set this yourself, below. The default is `vim`, and you're OK with that.
#----------------------------------------------------------------------------------

. /usr/lib/tflbp-sh/Err
. /usr/lib/tflbp-sh/ChkDep

BuildStore="$HOME/Documents/TT"
GitHub="$HOME/GitHub/terminalforlife/Personal/Extra/source"
ProgName=$1

# The build version of the program above.
if [ -n "$2" ]; then
	Version=$2
else
	Version=`bash $GitHub/$ProgName -v`
fi

PKGName="${ProgName}_${Version}_all.deb"
BuildConv="pkg-debian ($ProgName)"
WorkDir="$HOME/Desktop"
EDITOR=${EDITOR:-vim}

ChkDep id cp dpkg-deb find chown chmod bash stat sed

if [ `id -u` -ne 0 ]; then
	Err 1 'Root access is required for this operation.'
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
	# Currently, this script allows only for building packages already once built.
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
