"----------------------------------------------------------------------------------
" Project Name      - $HOME/.vimrc
" Started On        - Wed 20 Sep 09:36:54 BST 2017
" Last Change       - Mon  5 Mar 15:39:25 GMT 2018
" Author E-Mail     - terminalforlife@yahoo.com
" Author GitHub     - https://github.com/terminalforlife
"----------------------------------------------------------------------------------

" Remap to sane, touch-typing standard movement keys.
noremap j h
noremap k j
noremap l k
noremap ; l

" Useful in DocMode(). Traverse lines normally.
noremap k gj
noremap l gk

" Set the initial variable values, prior to further processing.
let g:autoscrollstate="false"
let g:moremodestate="false"
let g:hardmodestate="false"
let g:docmodestate="false"
let g:mousesupportstate="false"
let g:virtualeditstate="false"
let g:textwidthmode="false"
let mapleader=","

" Allow recursive fuzzy finding.
set path+=**

" Stop asking VIM to act like ancient vi.
set nocompatible

" Don't clutter your drive with swap and backup files.
set noswapfile
set nobackup

" ???
set matchtime=0

" Disable text wrapping.
set nowrap

" Allow 256 colors. Redundant?
set t_Co=256

" Make the ESC timeout sane.
set ttimeout
set ttimeoutlen=10

" ???
set viewoptions=folds,options,cursor,unix,slash

"Longer command history. Default is apparently 20.
set history=4000

"set listchars=tab:-,trail:,extends:#,nbsp:.
set listchars=tab:»→,trail:␣,extends:#,nbsp:⊗

" Disable the ruler.
set noruler

" Set the status line at the bottom of VIM.
set statusline=\ %F%m%r%h%w\ \ FF=%{&ff}\ \ T=%Y\ \ A=\%03.3b\ \ H=\%02.2B\ \ POS=%04l,%04v\ \ %p%%\ \ LEN=%L

" ???
set cmdheight=1

" Display VIM's current mode; insert and visual.
set showmode

" Set the way in which folds are registered.
set foldmethod=marker

" Set the marker used to recognise a fold.
set foldmarker=#\ {{{,#\ }}}

" Disable search highlighting.
set nohlsearch

" ???
set wildchar=<TAB>

" Display a menu in : when tab shows multiple possibilities.
set wildmenu

" ???
set wrapmargin=0

" ???
set nomore

" Enables live searching; search as you type.
set incsearch

" Superficially use 8-space tabs; set this for reference.
set tabstop=8

" A function responsible for both un- and commenting lines of text, depending on
" the laguage the currently edited file is using or marked as.
func! ComTog(action)
	exe "silent normal! mc"

	if(a:action == "comment")
		if(&filetype == "python" || &filetype == "sh")
			exe "silent normal! 0i#\<Esc>"
		elseif(&filetype == "vim")
			exe "silent normal! 0i\"\<Esc>"
		elseif(len(&filetype) == 0)
			echo "ERROR: Cannot comment -- missing file type."
		else
			echo "ERROR: Cannot comment -- unknown file type."
		endif
	elseif(a:action == "uncomment")
		if(len(&filetype) > 0)
			exe "silent normal! 0x"
		elseif(len(&filetype) == 0)
			echo "ERROR: Cannot comment -- missing file type."
		else
			echo "ERROR: Cannot comment -- unknown file type."
		endif
	else
		echo "ERROR: Invalid action at position 1."
	endif

	exe "silent normal! `c"
endfunc

" Just holds some extra color settings for tfl.
func! ExtraColorSets()
	if(g:colors_name == "tfl")
		hi SpecialKey     ctermfg=darkyellow   ctermbg=NONE
		hi ColorColumn    ctermbg=235          ctermfg=250
		hi CursorLine     ctermbg=237          cterm=bold
		hi StatusLine     ctermbg=white        ctermfg=black
		hi VertSplit      ctermbg=black        ctermfg=black
		hi StatusLine     ctermbg=white        ctermfg=black
		hi StatusLineNC   ctermbg=238          ctermfg=black
		hi Comment        ctermbg=NONE         ctermfg=241
		hi TabLineFill    ctermbg=0            ctermfg=0
	else
		echo "ERROR: Wrong colorscheme selected -- use tfl."
	endif
endfunc

" Function deals with autoscrolling.
func! AutoScroll()
	if(g:autoscrollstate == "false")
		let g:autoscrollstate="true"
		set sidescrolloff=999
		set scrolloff=999
		echo "Automatic scrolling is enabled."
	elseif(g:autoscrollstate == "true")
		let g:autoscrollstate="false"
		set sidescrolloff=0
		set scrolloff=0
		echo "Automatic scrolling is disabled."
	endif
endfunc

" The function for toggling mouse support.
func! MouseSupport()
	if(len($DISPLAY) > 0 )
		set mousehide!

		if(g:mousesupportstate == "false")
			let g:mousesupportstate="true"
			set mouse=a
			echo "Mouse support enabled."
		elseif(g:mousesupportstate == "true")
			let g:mousesupportstate="false"
			set mouse=
			echo "Mouse support disabled."
		endif
	else
		echo "ERROR: Uknown display -- are you in a TTY?"
	endif
endfunc

" The function for toggling virtual editing.
func! VirtualEdit()
	if(g:virtualeditstate == "true")
		let g:virtualeditstate="false"
		set virtualedit=
		echo "Virtual editing is disabled."
	elseif(g:virtualeditstate == "false")
		let g:virtualeditstate="true"
		set virtualedit=all
		echo "Virtual editing is enabled."
	endif
endfunc

" The function for toggling DocMode.
func! DocMode()
	set linebreak!
	set wrap!

	if(g:docmodestate == "false")
		let g:docmodestate="true"
		echo "Document Mode is disabled."
		syntax on
		silent call ExtraColorSets()
	elseif(g:docmodestate == "true")
		let g:docmodestate="false"
		syntax off
		silent call ExtraColorSets()

		if(&list == 1)
			set nolist
		endif

		if(g:moremodestate == "true")
			echo "Document Mode is enabled and More Mode is disabled."
			silent call MoreMode()
		elseif(g:moremodestate == "false")
			echo "Document Mode is enabled."
		endif
	endif
endfunc

" The function for toggling ListMode.
func! ListMode()
	set list!

	if(&list == 1 )
		echo "List mode is enabled."
	elseif(&list == 0 )
		echo "List mode is disabled."
	endif
endfunc

" Alternate between relative and standard line numbers. If both are enabled, then
" fix this by toggling number, which results in either just the number setting, or
" only the relativenumber setting.
func! LineNumAlt()
	if(&relativenumber == 1 && &number == 0)
		set relativenumber!
		set number
	elseif(&relativenumber == 0 && &number == 1)
		set number!
		set relativenumber
	else
		set nonumber!
	endif
endfunc

" The function for toggling MoreMode.
func! MoreMode()
	set showmatch!
	set ruler!
	set cursorline!

	if(&relativenumber == 1 || &number == 1)
		set norelativenumber
		set nonumber
	elseif(&relativenumber == 0 && &number == 0)
		silent call LineNumAlt()
	endif

	if(g:moremodestate == "false")
		let g:moremodestate="true"
		set colorcolumn=84
		set laststatus=2
		echo "More mode is enabled."
	elseif(g:moremodestate == "true")
		let g:moremodestate="false"
		set colorcolumn=0
		set laststatus=1
		echo "More mode is disabled."
	endif
endfunc

" The function for toggling HardMode. Incomplete.
func! HardMode()
	if(g:hardmodestate == "false")
		let g:hardmodestate="true"
		noremap j <Nop>
		noremap k <Nop>
		noremap l <Nop>
		noremap ; <Nop>
		echo "Hard mode is enabled."
	elseif(g:hardmodestate == "true")
		let g:hardmodestate="false"
		noremap ; l
		noremap l k
		noremap k j
		noremap j h
		echo "Hard mode is disabled."
	endif
endfunc

" Set textwidth to 84.
func! TextWidth()
	if(g:textwidthmode == "false")
		let g:textwidthmode="true""
		set textwidth=84
		echo "TextWidth() is enabled."
	elseif(g:textwidthmode == "true")
		let g:textwidthmode="false"
		set textwidth=0
		echo "TextWidth() is disabled."
	endif
endfunc

" Set colors depending on terminal type.
if(&ttytype == "xterm-256color")
	colorscheme tfl
	set background=dark
	set ttyfast
else
	colorscheme darkblue
	set background=dark
	set nottyfast
endif

" Select different color presets.
func! ColorPreset(preset)
	if(a:preset == "default")
		colorscheme default
		set background=dark
	elseif(a:preset == "tfl")
		colorscheme tfl
		set background=dark
		silent call ExtraColorSets()
	else
		echo "ERROR: Invalid color preset selected."
	endif
endfunc

" Enter a shell user-specified (position 1) shebang, of method (position 2).
func! Bang(shell, method)
	if(a:method == "default")
		if(a:shell == "bash")
			exe "normal! ggi#!/bin/bash\<CR>\<CR>\<Esc>G"
		elseif(a:shell == "sh")
			exe "normal! ggi#!/bin/sh\<CR>\<CR>\<Esc>G"
		else
			echo "ERROR: Invalid shell type."
		endif
	elseif(a:method == "env")
		if(a:shell == "bash")
			exe "normal! ggi#!/usr/bin/env bash\<CR>\<CR>\<Esc>G"
		elseif(a:shell == "sh")
			exe "normal! ggi#!/usr/bin/env sh\<CR>\<CR>\<Esc>G"
		else
			echo "ERROR: Invalid shell environment type."
		endif
	endif
endfunc

" Enter a tidy header.
func! Header()
	exe "silent normal! i#\<Esc>82a-\<Esc>o"
	exe "silent normal! i# Project Name      - \<CR>"
	exe "silent normal! i# Started On        - \<Esc>\"_\"=strftime(\"%a %_d %b %T %Z %Y\")\<CR>po"
	exe "silent normal! i# Last Change       - \<Esc>\"_\"=strftime(\"%a %_d %b %T %Z %Y\")\<CR>po"
	exe "silent normal! i# Author E-Mail     - terminalforlife@yahoo.com\<CR>"
	exe "silent normal! i# Author GitHub     - https://github.com/terminalforlife\<CR>"
	exe "silent normal! i#\<Esc>82a-\<Esc>0o"
endfunc

" Function to update header's timestamp and the _VERSION_ variable datestamp in
" shell scripts/programs, if this variable is found. Also cleans up spacing.
func! LastChange()
	exe "silent normal! mc"

	if(search("^[#/\"]* Last Change\\s*- ", "ep") > 0)
		exe "silent normal! ld$\"_\"=strftime(\"%a %_d %b %T %Z %Y\")\<CR>p"
		if(search("^_VERSION_=\"", "ep") > 0)
			exe "silent normal! da\"\"_\"=strftime(\"\\\"%F\\\"\")\<CR>p"
		endif
	endif

	exe "silent normal! :%s/\\s*$//\<CR>"
	exe "silent normal! :%s/\\t*$//\<CR>`c"
endfunc

" Function to insert just the XERR and ERR functions into a shell script.
func! Err()
	exe "silent normal! 0iXERR(){ printf \"[L%0.4d] ERROR: %s\\n\" \"$1\" \"$2\" 1>&2; exit 1; }\<CR>"
	exe "silent normal! 0iERR(){ printf \"[L%0.4d] ERROR: %s\\n\" \"$1\" \"$2\" 1>&2; }\<CR>"
endfunc

" ???
func! ML()
	exe "silent normal! mc"

	if(search("^[#/\"]* vim: ", "p") == 0)
		exe "silent normal! G0i# vim: noexpandtab colorcolumn=84 tabstop=8 noswapfile nobackup\<Esc>`c"
	else
		echo "ERROR: VIM Modeline already present."
	endif
endfunc

" Lol. Why didn't I use a snippet file? Oh well, very useful for shell (bash).
func! Setup()
	exe "silent normal! 0i_VERSION_=\"\<ESC>\"_\"=strftime(\"%F\")\<CR>pa\"\<CR>\<CR>"
	exe "silent normal! 0iXERR(){ printf \"[L%0.4d] ERROR: %s\\n\" \"$1\" \"$2\" 1>&2; exit 1; }\<CR>"
	exe "silent normal! 0iERR(){ printf \"[L%0.4d] ERROR: %s\\n\" \"$1\" \"$2\" 1>&2; }\<CR>\<CR>"

	exe "silent normal! 0ideclare -i DEPCOUNT=0\<CR>"
	exe "silent normal! 0ifor DEP in PATH; {\<CR>"
	exe "silent normal! 0i\<Tab>[ -x \"$DEP\" ] || {\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>ERR \"$LINENO\" \"Dependency '$DEP' not met.\"\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>DEPCOUNT+=1\<CR>\<Tab>}\<CR>}\<CR>\<CR>"
	exe "silent normal! 0i[ $DEPCOUNT -eq 0 ] || exit 1\<CR>\<CR>"

	exe "silent normal! 0iUSAGE(){\<CR>\<Tab>while read -r; do\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>printf \"%s\\n\" \"$REPLY\"\<CR>\<Tab>done <<-EOF\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>            EXAMPLE ($_VERSION_)\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>            Written by terminalforlife (terminalforlife@yahoo.com)\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>            Dummy description for this template.\<CR>\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>SYNTAX:     example [OPTS]\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>OPTS:       --help|-h|-?            - Displays this help information.\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>            --version|-v            - Output only the version datestamp.\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>            --quiet|-q              - Runs in quiet mode. Errors still output.\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>            --debug|-D              - Enables the built-in bash debugging.\<CR>"
	exe "silent normal! 0i\<Tab>EOF\<CR>}\<CR>\<CR>"

	exe "silent normal! 0iwhile [ \"$1\" ]; do\<CR>\<Tab>case \"$1\" in\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>--help|-h|-\\?)\<CR>\<Tab>\<Tab>\<Tab>USAGE; exit 0 ;;\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>--debug|-D)\<CR>\<Tab>\<Tab>\<Tab>DEBUGME=\"true\" ;;\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>--quiet|-q)\<CR>\<Tab>\<Tab>\<Tab>BEQUIET=\"true\" ;;\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>--version|-v)\<CR>\<Tab>\<Tab>\<Tab>printf \"%s\\n\" \"$_VERSION_\" ;;\<CR>"
	exe "silent normal! 0i\<Tab>\<Tab>*)\<CR>\<Tab>\<Tab>\<Tab>XERR \"$LINENO\" \"Incorrect argument(s) specified.\" ;;\<CR>"
	exe "silent normal! 0i\<Tab>esac\<CR>\<CR>\<Tab>shift\<CR>done\<CR>\<CR>"

	exe "silent normal! 0i[ $UID -eq 0 ] && XERR \"$LINENO\" \"Root access isn't required.\"\<CR>\<CR>"

	exe "silent normal! 0i[ \"$BEQUIET\" == \"true\" ] && exec 1> /dev/null\<CR>"

	exe "silent normal! 0i[ \"$DEBUGME\" == \"true\" ] && set -x\<CR>\<CR>"
	exe "silent normal! 0i\<CR>\<CR># vim: noexpandtab colorcolumn=84 tabstop=8 noswapfile nobackup\<Esc>kk"
endfunc

" Enable syntax highlighting.
syntax on

" Sets Insert Remappings
inoremap <up> <Nop>
inoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>

" Press spacebar to clear search highlighting.
noremap <silent> <SPACE> :noh<CR>

" Disable the arrow keys.
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

" Switch to a different color preset.
noremap <silent> <leader>color1 :call ColorPreset("default")<CR>
noremap <silent> <leader>color2 :call ColorPreset("tfl")<CR>

" Re-source the .vimrc file; can cause issues.
noremap <silent> <leader>rc :source $HOME/.vimrc<CR>

" Display helpful screen information; good for code.
noremap <silent> <leader>more :call MoreMode()<CR>

" Toggle between textwidth 84 and textwidth 0.
noremap <silent> <leader>tw :call TextWidth()<CR>

" Toggle the display of tabs and spaces.
noremap <silent> <leader>list :call ListMode()<CR>

" Work in progress. Toggles a stricter VIM.
noremap <silent> <leader>hard :call HardMode()<CR>

" Use VIM as a standard text editor, for non-code.
noremap <silent> <leader>doc :call DocMode()<CR>

" Toggle moving the cursor and the screen simultaneously.
noremap <silent> <leader>scroll :call AutoScroll()<CR>

" Toggle the ability to move the cursor anyway.
noremap <silent> <leader>virt :call VirtualEdit()<CR>

" Toggle the mouse support.
noremap <silent> <leader>mouse :call MouseSupport()<CR>

" Uses the header to update the modified date and save.
noremap <silent> <leader>save :call LastChange()<CR>

" Adds a lot of nice shell (bash) code in preperation.
noremap <silent> <leader>setup :call Setup()<CR>

" ???
noremap <silent> <leader>modeline :call ML()<CR>

" Add just the XERR and ERR functions.
noremap <silent> <leader>err :call Err()<CR>

" Enter hashbangs on the first line.
noremap <silent> <leader>bash :call Bang("bash", "default")<CR>
noremap <silent> <leader>shell :call Bang("sh", "default")<CR>

" Underline below the current; uses the same length.
noremap <silent> <leader>ul mmyypVr-<Esc>`m

" Add a header at the current position.
noremap <silent> <leader>header :call Header()<CR>

" Add a header at the current position.
noremap <silent> <leader>lines :call LineNumAlt()<CR>

" Toggle comments, depending on the file type.
noremap <silent> <leader>co :call ComTog("comment")<CR>
noremap <silent> <leader>uc :call ComTog("uncomment")<CR>

" Use VIM's window splitting and switching.
noremap <silent> <leader>ws :split<CR>
noremap <silent> <leader>wvs :vsplit<CR>
noremap <silent> <leader>wc :close<CR>

" Current line text alignment.
noremap <silent> <leader>ac :center<CR>
noremap <silent> <leader>ar :right<CR>
noremap <silent> <leader>al :left<CR>

" Jump to the next or previous file.
noremap <silent> <leader>nn :next<CR>
noremap <silent> <leader>pp :prev<CR>

" Write file and then execute current file with...
noremap <silent> <leader>rwP :w<CR>:!/usr/bin/python %<CR>
noremap <silent> <leader>rwp :w<CR>:!/usr/bin/python3.5 %<CR>
noremap <silent> <leader>rwb :w<CR>:!/bin/bash %<CR>
noremap <silent> <leader>rws :w<CR>:!/bin/sh %<CR>

" Execute current file with...
noremap <silent> <leader>rP :!/usr/bin/python %<CR>
noremap <silent> <leader>rp :!/usr/bin/python3.5 %<CR>
noremap <silent> <leader>rb :!/bin/bash %<CR>
noremap <silent> <leader>rs :!/bin/sh %<CR>

" Because I keep forgetting to sudo rvim FILE.
noremap <silent> <leader>sudosave :w !/usr/bin/sudo /usr/bin/tee %<CR>

" Toggle the spellchecking feature.
noremap <leader>spell :set spell!<CR>

" Toggle the search highlighting.
noremap <leader>hl :set hlsearch!<CR>

" Display a comment bar, using a hash.
noremap <silent> <leader>bar 0i#<Esc>82a-<Esc>0

" Remove the single quotes, double quotes, parens, and graves. (left to right)
noremap <silent> <leader>rdq mmF"xf"x`m
noremap <silent> <leader>rsq mmF'xf'x`m
noremap <silent> <leader>rg mmF`xf`x`m
"noremap <silent> <leader>rp mmF(xf)x`m

"TODO - Fix. Seems to just stop after the first key.
" Easy insert scrolling.
"inoremap <C-L> <C-X><C-E>
"inoremap <C-K> <C-X><C-Y>

" Sets Jump Points (rough)
noremap <silent> K 10j
noremap <silent> L 10k

" Sets Jump Points (smooth)
"noremap <silent> K jjjjjjjjjj
"noremap <silent> L kkkkkkkkkk

" Sets Visual Remappings
vnoremap <up> <Nop>
vnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>

" Function Calls
silent call AutoScroll()
silent call ExtraColorSets()
silent call MoreMode()

" Correct stupid typo.
ab teh the

" Source $HOME/VimPlugins
source $HOME/VimPlugins/datepaste.vim

" Adds security.
set secure
