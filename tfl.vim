" Based on 256_noir. Written by terminalforlife. (terminalforlife@yahoo.com)

" 1=red 124=darkred 232-255=black-white 226=yellow

set background=dark
highlight clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "tfl"
hi Normal                   ctermbg=NONE         ctermfg=255
hi Boolean                  ctermbg=NONE         ctermfg=1
hi Character                ctermbg=NONE         ctermfg=196
hi Comment                  ctermbg=NONE         ctermfg=240
hi Condtional               ctermbg=NONE         ctermfg=196
hi Constant                 ctermbg=NONE         ctermfg=252
hi Cursor                   ctermbg=NONE         ctermfg=NONE
hi ColorColumn              ctermbg=NONE         ctermfg=NONE
hi CursorColumn             ctermbg=NONE         ctermfg=NONE
hi Debug                    ctermbg=255          ctermfg=NONE
hi Define                   ctermbg=NONE         ctermfg=255
hi Delimiter                ctermbg=NONE         ctermfg=250
hi Directory                ctermbg=NONE         ctermfg=255
hi Error                    ctermbg=1            ctermfg=0
hi Exception                ctermbg=NONE         ctermfg=250
hi Float                    ctermbg=NONE         ctermfg=196
hi FoldColumn               ctermbg=NONE         ctermfg=196
hi Folded                   ctermbg=NONE         ctermfg=196
hi Function                 ctermbg=NONE         ctermfg=196
hi Identifier               ctermbg=NONE         ctermfg=158
hi Include                  ctermbg=NONE         ctermfg=255
hi Keyword                  ctermbg=NONE         ctermfg=255
hi Label                    ctermbg=NONE         ctermfg=255
hi LineNr                   ctermbg=232          ctermfg=240
hi MatchParen               ctermbg=NONE         ctermfg=70
hi Macro                    ctermbg=NONE         ctermfg=yellow
hi ModeMsg                  ctermbg=NONE         ctermfg=250
hi MoreMsg                  ctermbg=NONE         ctermfg=250
hi NonText                  ctermbg=NONE         ctermfg=240
hi Number                   ctermbg=NONE         ctermfg=255
hi Operator                 ctermbg=NONE         ctermfg=196
hi Pmenu                    ctermbg=NONE         ctermfg=255
hi PmenuSel                 ctermbg=NONE         ctermfg=70
hi PmenuSbar                ctermbg=NONE         ctermfg=70
hi PmenuThumb               ctermbg=NONE         ctermfg=232
hi PreCondit                ctermbg=NONE         ctermfg=255
hi PreProc                  ctermbg=NONE         ctermfg=196
hi Question                 ctermbg=NONE         ctermfg=250
hi Repeat                   ctermbg=NONE         ctermfg=255
hi Search                   ctermbg=255          ctermfg=0
hi SpecialChar              ctermbg=NONE         ctermfg=255
hi SpecialComment           ctermbg=NONE         ctermfg=250
hi Special                  ctermbg=NONE         ctermfg=255
hi SpecialKey               ctermbg=NONE         ctermfg=70
hi Statement                ctermbg=NONE         ctermfg=230
hi StatusLine               ctermbg=NONE         ctermfg=196
hi StatusLineNC             ctermbg=NONE         ctermfg=250
hi StorageClass             ctermbg=NONE         ctermfg=255
hi String                   ctermbg=NONE         ctermfg=96
hi Structure                ctermbg=NONE         ctermfg=255
hi Tag                      ctermbg=NONE         ctermfg=196
hi Title                    ctermbg=NONE         ctermfg=250
hi Todo                     ctermbg=NONE         ctermfg=255
hi Typedef                  ctermbg=NONE         ctermfg=255
hi Type                     ctermbg=NONE         ctermfg=255
hi VertSplit                ctermbg=NONE         ctermfg=250
hi WarningMsg               ctermbg=NONE         ctermfg=196
hi WildMenu                 ctermbg=NONE         ctermfg=240
hi Visual                   ctermbg=NONE         ctermfg=2
hi VisualNOS                ctermbg=NONE         ctermfg=70
hi IncSearch                ctermbg=255          ctermfg=0
hi ErrorMsg                 ctermbg=NONE         ctermfg=255
hi SpellBad                 ctermbg=1            ctermfg=0
hi SpellCap                 ctermbg=NONE         ctermfg=255
hi SpellLocal               ctermbg=NONE         ctermfg=255
hi SpellRare                ctermbg=NONE         ctermfg=124
hi DiffAdd                  ctermbg=NONE         ctermfg=255
hi DiffChange               ctermbg=NONE         ctermfg=700
hi DiffDelete               ctermbg=NONE         ctermfg=240
hi DiffText                 ctermbg=NONE         ctermfg=250

hi def link diffCommon Statement
hi def link diffRemoved DiffDelet
hi def link diffChanged DiffChang
hi def link diffAdded DiffAdd
