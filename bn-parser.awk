#!/usr/bin/awk

#----------------------------------------------------------------------------------
# Project Name      - Extra/bn-parser.awk
# Started On        - Sat 16 Nov 22:41:17 GMT 2019
# Last Change       - Sun 17 Nov 00:50:54 GMT 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Work in progress!
#
# This is a project inspired greatly by a shell script in a repository by a GitHub
# user, named 'jonasjberg'. In the process of improving it for a pull request, I
# found myself going somewhere a little different: doing it all (almost) with AWK.
#
# If using vim and want syntax highlighting, but the comments are messed up, then
# run the following command from a terminal with root access:
#
#   sed -ri 's/^syn\s+match\s+awkComment\s+.*$/syn match awkComment "^[[:space:]]*#.*$" contains=@Spell,awkTodo/' /usr/share/vim/vim74/syntax/awk.vim
#----------------------------------------------------------------------------------

BEGIN{
	for(I in ARGV){
		File=ARGV[I+1]
		sub(/\.{1}.*$/, "", File)

		gsub(/(&| -and- )/, "-and-", File)
		gsub(/(@| -AT- )/, "-AT-", File)

		gsub(/(, | |,)/, "_", File)
		gsub(/[\'\"\!\\\/]/, "", File)
		gsub(/\n/, "_", File)
		gsub(/[.\(\)\[\]\{\}]/, "_", File)
		gsub(/[_-]{2,}/, "_", File)

		gsub(/C\+\+/, "CPP", File)
		gsub(/C#/, "CSharp", File)

		print(File)
	}
}
