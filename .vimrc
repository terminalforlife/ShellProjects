" Essential Remaps
noremap j h
noremap k j
noremap l k
noremap ; l

" Variable Letting
let g:autoscrollstate=0
let g:moremodestate=0
let g:hardmodestate=0
let g:docmodestate=1
let g:mousesupportstate=0
let g:virtualeditstate=0
let mapleader=","

" Standard Sets
set nocompatible
set noswapfile
set matchtime=0
set nobackup
set nowrap
set ttimeout
set ttimeoutlen=10
set viewoptions=folds,options,cursor,unix,slash
set history=4000 "Longer command history. Default is apparently 20.
set listchars=tab:»→,trail:→,extends:#,nbsp:.
"set listchars=tab:-,trail:,extends:#,nbsp:.
set noruler
set statusline=\ %F%m%r%h%w\ \ FF=%{&ff}\ \ T=%Y\ \ A=\%03.3b\ \ H=\%02.2B\ \ POS=%04l,%04v\ \ %p%%\ \ LEN=%L
set cmdheight=1
set showmode
set foldmethod=marker
set foldmarker=#\ {{{,#\ }}}
set hlsearch
set wildchar=<TAB>
set wildmenu
set wrapmargin=0
set nomore
set incsearch

func! ExtraColorSets()
	hi SpecialKey     ctermfg=darkyellow   ctermbg=NONE
	hi ColorColumn    ctermbg=235          ctermfg=250
	hi CursorLine     ctermbg=237          cterm=bold
	hi StatusLine     ctermfg=black        ctermbg=white
	hi VertSplit      ctermbg=black        ctermfg=black
	hi StatusLine     ctermbg=white        ctermfg=black
	hi StatusLineNC   ctermbg=238          ctermfg=black
	hi Comment        ctermfg=241
endfunc

func! CleanupThenSave()
	exe "normal! :%s/\\s\\+$//\<CR>"
	exe "normal! :%s/\\t\\+$//\<CR>"
	write
endfunc

func! AutoScroll()
	if(g:autoscrollstate == 0)
		let g:autoscrollstate = 1
		set sidescrolloff=999
		set scrolloff=999
		echo "Automatic scrolling is enabled."
	elseif(g:autoscrollstate == 1)
		let g:autoscrollstate = 0
		set sidescrolloff=0
		set scrolloff=0
		echo "Automatic scrolling is disabled."
	endif
endfunc

func! MouseSupport()
	if(g:mousesupportstate == 0)
		let g:mousesupportstate = 1
		set mouse=a
		echo "Mouse support enabled."
	elseif(g:mousesupportstate == 1)
		let g:mousesupportstate = 0
		set mouse=
		echo "Mouse support disabled."
	endif
endfunc

func! VirtualEdit()
	if(g:virtualeditstate == 1)
		let g:virtualeditstate = 0
		set virtualedit=
		echo "Virtual editing is disabled."
	elseif(g:virtualeditstate == 0)
		let g:virtualeditstate = 1
		set virtualedit=all
		echo "Virtual editing is enabled."
	endif
endfunc

func! DocMode()
	set linebreak!
	set wrap!

	if(g:docmodestate == 0)
		let g:docmodestate = 1
		echo "Document Mode is disabled."
		syntax on
		silent call ExtraColorSets()
	elseif(g:docmodestate == 1)
		let g:docmodestate = 0
		syntax off
		silent call ExtraColorSets()

		if(&list == 1)
			set nolist
		endif

		if(g:moremodestate == 1)
			echo "Document Mode is enabled and More Mode is disabled."
			silent call MoreMode()
		elseif(g:moremodestate == 0)
			echo "Document Mode is enabled."
		endif
	endif
endfunc

func! ListMode()
	set list!

	if(&list == 1 )
		echo "List mode is enabled."
	elseif(&list == 0 )
		echo "List mode is disabled."
	endif
endfunc

func! MoreMode()
	set showmatch!
	set ruler!
	set cursorline!
	set relativenumber!
	"set number!

	if(g:moremodestate == 0)
		let g:moremodestate = 1
		set colorcolumn=84
		set laststatus=2
		echo "More mode is enabled."
	elseif(g:moremodestate == 1)
		let g:moremodestate = 0
		set colorcolumn=0
		set laststatus=1
		echo "More mode is disabled."
	endif
endfunc

func! HardMode()
	if(g:hardmodestate == 0)
		let g:hardmodestate = 1
		noremap j <Nop>
		noremap k <Nop>
		noremap l <Nop>
		noremap ; <Nop>
		echo "Hard mode is enabled."
	elseif(g:hardmodestate == 1)
		let g:hardmodestate = 0
		noremap ; l
		noremap l k
		noremap k j
		noremap j h
		echo "Hard mode is disabled."
	endif
endfunc

if(&ttytype == "xterm-256color")
	colorscheme tfl
	set background=dark
	set ttyfast
else
	colorscheme darkblue
	set background=dark
	set nottyfast
endif

func! ColorPreset1()
	colorscheme default
	set background=dark
endfunc

func! ColorPreset2()
	colorscheme tfl
	set background=dark
	silent call ExtraColorSets()
endfunc

func! HashBang()
	exe "normal! ggi#!/bin/bash\<CR>\<CR>\<Esc>G"
endfunc

func! ShHashBang()
	exe "normal! ggi#!/bin/sh\<CR>\<CR>\<Esc>G"
endfunc

func! Header()
	exe "normal! i#\<Esc>82a-\<Esc>o"
	exe "normal! i# Project Name      - \<CR>"
	exe "normal! i# Started On        - \<Esc>:r!date\<CR>i\<c-h>\<Esc>A\<CR>"
	exe "normal! i# Last Change       - \<CR>"
	exe "normal! i# Author E-Mail     - terminalforlife@yahoo.com\<CR>"
	exe "normal! i# Author GitHub     - https://github.com/terminalforlife\<CR>"
	exe "normal! i#\<Esc>82a-\<Esc>0o"
endfunc

func! LastChange()
	exe "normal! mcgg/# Last Change\<CR>f-c$- \<Esc>:r!date\<CR>i\<c-h>\<Esc>`c"
	write
endfunc

func! Setup()
	exe "normal! 0iXERR(){ echo \"ERROR: $1\" 1>&2; exit 1; }\<CR>"
	exe "normal! 0iERR(){ echo \"ERROR: $1\" 1>&2; }\<CR>\<CR>"

	exe "normal! 0i[ $UID -eq 0 ] && XERR \"Root access isn't required.\"\<CR>\<CR>"

	exe "normal! 0iDEPCOUNT=0\<CR>"
	exe "normal! 0ifor DEP in /usr/bin/{} /bin/{cat} /sbin/{}\<CR>{\<CR>"
	exe "normal! 0i\<Tab>if ! type -P \"$DEP\" &> /dev/null\<CR>\<Tab>then\<CR>"
	exe "normal! 0i\<Tab>\<Tab>ERR \"Dependency '$DEP' not met.\"\<CR>"
	exe "normal! 0i\<Tab>\<Tab>let DEPCOUNT++\<CR>\<Tab>fi\<CR>}\<CR>\<CR>"
	exe "normal! 0i[ $DEPCOUNT -eq 0 ] || exit 1\<CR>\<CR>"

	exe "normal! 0ishopt -s extglob\<CR>\<CR>"

	exe "normal! 0iUSAGE()\<CR>{\<CR>\<Tab>/bin/cat <<-EOF\<CR>"
	exe "normal! 0i\<Tab>\<Tab>            Example (9th September 2017)\<CR>"
	exe "normal! 0i\<Tab>\<Tab>            Written by terminalforlife (terminalforlife@yahoo.com)\<CR>"
	exe "normal! 0i\<Tab>\<Tab>\<CR>"
	exe "normal! 0i\<Tab>\<Tab>            Description Here\<CR>\<CR>"
	exe "normal! 0i\<Tab>\<Tab>SYNTAX:     example [OPTS]\<CR>"
	exe "normal! 0i\<Tab>\<Tab>\<CR>"
	exe "normal! 0i\<Tab>\<Tab>OPTS:       --help|-h|-?            - Displays this help information.\<CR>"
	exe "normal! 0i\<Tab>\<Tab>            --debug                 - Enables the built-in bash debugging.\<CR>"
	exe "normal! 0i\<Tab>\<Tab>            --quiet|-q              - Runs in quiet mode. Errors still output.\<CR>"
	exe "normal! 0i\<Tab>\<Tab>\<CR>"
	exe "normal! 0i\<Tab>\<Tab>NOTE:       N/A\<CR>"
	exe "normal! 0i\<Tab>EOF\<CR>}\<CR>\<CR>"

	exe "normal! 0ifor ARG in $@\<CR>{\<CR>\<Tab>case \"$ARG\"\<CR>\<Tab>in\<CR>"
	exe "normal! 0i\<Tab>\<Tab>--help|-h|-\\?)\<CR>\<Tab>\<Tab>\<Tab>USAGE; exit 0 ;;\<CR>"
	exe "normal! 0i\<Tab>\<Tab>--debug)\<CR>\<Tab>\<Tab>\<Tab>DEBUGME=\"true\" ;;\<CR>"
	exe "normal! 0i\<Tab>\<Tab>--quiet|-q)\<CR>\<Tab>\<Tab>\<Tab>BEQUIET=\"true\" ;;\<CR>"
	exe "normal! 0i\<Tab>\<Tab>*)\<CR>\<Tab>\<Tab>\<Tab>XERR \"Incorrect argument(s) specified.\" ;;\<CR>"
	exe "normal! 0i\<Tab>esac\<CR>}\<CR>\<CR>"

	exe "normal! 0i[ \"$BEQUIET\" == \"true\" ] && exec 1> /dev/null\<CR>"

	exe "normal! 0i[ \"$DEBUGME\" == \"true\" ] && set -xeu\<CR>\<CR>\<CR>\<CR>"
	exe "normal! 0i[ \"$DEBUGME\" == \"true\" ] && set +xeu\<Esc>kk"
endfunc

" Non-Set Settings
syntax on

" Command Substitutions
"silent command! W :call CleanupThenSave()

" Sets Insert Remappings
inoremap <up> <Nop>
inoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>

" Sets Normal Remappings
noremap <silent> <SPACE> :noh<CR>
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

" Normal Leader Remappings
noremap <silent> <leader>color1 :call ColorPreset1()<CR>
noremap <silent> <leader>color2 :call ColorPreset2()<CR>
noremap <silent> <leader>pc :r !xclip -o -selection clipboard<CR>
noremap <silent> <leader>rc :source $HOME/.vimrc<CR>
noremap <silent> <leader>more :call MoreMode()<CR>
noremap <silent> <leader>list :call ListMode()<CR>
noremap <silent> <leader>hard :call HardMode()<CR>
noremap <silent> <leader>doc :call DocMode()<CR>
noremap <silent> <leader>scroll :call AutoScroll()<CR>
noremap <silent> <leader>virt :call VirtualEdit()<CR>
noremap <silent> <leader>mouse :call MouseSupport()<CR>
noremap <silent> <leader>save :call LastChange()<CR>
noremap <silent> <leader>setup :call Setup()<CR>
noremap <silent> <leader>bash :call HashBang()<CR>
noremap <silent> <leader>shell :call ShHashBang()<CR>
noremap <silent> <leader>ps :r !xclip -o<CR>
noremap <silent> <leader>ul mmyypVr-<Esc>`m
noremap <silent> <leader>co mmI#<Esc>`m
noremap <silent> <leader>uc mm0x`m
noremap <silent> <leader>header :call Header()<CR>
noremap <silent> <leader>ws :split<CR>
noremap <silent> <leader>wvs :vsplit<CR>
noremap <silent> <leader>wc :close<CR>
noremap <silent> <leader>ac :center<CR>
noremap <silent> <leader>ar :right<CR>
noremap <silent> <leader>al :left<CR>
noremap <silent> <leader>next :next<CR>
noremap <silent> <leader>previous :previous<CR>
noremap <leader>spell :set spell!<CR>
noremap <leader>hl :set hlsearch!<CR>
noremap <silent> <leader>bar 0i#<Esc>82a-<Esc>0

" Sets Jump Points
noremap <silent> K 10j
noremap <silent> L 10k

" Sets Visual Remappings
vnoremap <up> <Nop>
vnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>

" Function Calls
silent call AutoScroll()
silent call ExtraColorSets()
silent call MoreMode()

" Adds security.
set secure
