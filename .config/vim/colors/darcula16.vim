" JetBrains Darcula theme.
"
" Uses the 16 default ANSI colors and requires the terminal background to be
" ANSI black.

" This is a dark theme, so force dark background.
set background=dark

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = 'darcula16plus'

" Default highlight group links.
hi! link QuickFixLine Normal
hi! link Question Normal
hi! link Terminal Normal
hi! link CursorColumn CursorLine
hi! link ColorColumn CursorLine
hi! link CursorIM Cursor
hi! link EndOfBuffer NonText
hi! link Conceal NonText
hi! link SpecialKey NonText
hi! link ErrorMsg Error
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link SignColumn LineNr
hi! link Folded LineNr
hi! link FoldColumn Folded
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi! link TabLineFill TabLine
hi! link diffAdded String
hi! link diffRemoved WarningMsg
hi! link diffOnly WarningMsg
hi! link diffNoEOL WarningMsg
hi! link diffIsA WarningMsg
hi! link diffIdentical WarningMsg
hi! link diffDiffer WarningMsg
hi! link diffCommon WarningMsg
hi! link diffBDiffer WarningMsg
hi! link lCursor Cursor
hi! link CurSearch Search
hi! link IncSearch Search
hi! link VisualNOS Visual
hi! link WildMenu PmenuSel
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo
hi! link SpellCap SpellBad
hi! link SpellLocal SpellBad
hi! link SpellRare SpellBad

" LSP highlight group links.
hi! link LspErrorText Error
hi! link LspErrorHighlight Error
hi! link LspErrorVirtualText Error
hi! link LspWarningText WarningMsg
hi! link LspWarningHighlight WarningMsg
hi! link LspWarningVirtualText WarningMsg
hi! link LspInformationText Comment
hi! link LspInformationHighlight Comment
hi! link LspInformationVirtualText Comment
hi! link LspHintText NonText
hi! link LspHintHighlight NonText
hi! link LspHintVirtualText NonText
hi! link LspInlayHintsType NonText
hi! link LspInlayHintsParameter NonText

" ANSI colors:
" - 0: black
" - 1: red
" - 2: green
" - 3: yellow
" - 4: blue
" - 5: magenta
" - 6: cyan
" - 7: grey
" - 8: dark grey
" - 9: bright red
" - 10: bright green
" - 11: bright yellow
" - 12: bright blue
" - 13: bright magenta
" - 14: bright cyan
" - 15: white

" Appearance:
hi Normal ctermfg=15 ctermbg=NONE cterm=NONE
hi NonText ctermfg=7 ctermbg=NONE cterm=NONE
hi LineNr ctermfg=7 ctermbg=8 cterm=NONE
hi CursorLineNr ctermfg=15 ctermbg=8 cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=8 cterm=NONE
hi VertSplit ctermfg=7 ctermbg=8 cterm=NONE
hi StatusLine ctermfg=15 ctermbg=8 cterm=NONE
hi StatusLineNC ctermfg=7 ctermbg=8 cterm=NONE
hi TabLine ctermfg=7 ctermbg=8 cterm=NONE
hi TabLineSel ctermfg=15 ctermbg=8 cterm=NONE
hi Title ctermfg=11 ctermbg=NONE cterm=NONE

" Menus:
hi Pmenu ctermfg=15 ctermbg=8 cterm=NONE
hi PmenuSel ctermfg=15 ctermbg=8 cterm=inverse,nocombine
hi PmenuSbar ctermfg=NONE ctermbg=8 cterm=NONE
hi PmenuThumb ctermfg=NONE ctermbg=7 cterm=NONE

" Highlighting:
hi Visual ctermfg=0 ctermbg=3 cterm=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=inverse,nocombine
hi MatchParen ctermfg=11 ctermbg=8 cterm=NONE
hi Directory ctermfg=4 ctermbg=NONE cterm=NONE
hi SpellBad ctermbg=NONE cterm=undercurl,nocombine
hi WarningMsg ctermfg=3 ctermbg=NONE cterm=NONE

" Diffs:
hi DiffAdd ctermfg=2 ctermbg=NONE cterm=NONE
hi DiffChange ctermfg=3 ctermbg=NONE cterm=NONE
hi DiffDelete ctermfg=1 ctermbg=NONE cterm=NONE
hi DiffText ctermfg=11 ctermbg=NONE cterm=bold,nocombine

" Comments:
hi Comment ctermfg=7 ctermbg=NONE cterm=NONE

" Constants:
hi Constant ctermfg=5 ctermbg=NONE cterm=italic,nocombine
hi String ctermfg=2 ctermbg=NONE cterm=NONE
hi Character ctermfg=2 ctermbg=NONE cterm=NONE
hi Number ctermfg=4 ctermbg=NONE cterm=NONE
hi Boolean ctermfg=5 ctermbg=NONE cterm=NONE
hi Float ctermfg=4 ctermbg=NONE cterm=NONE

" Identifiers:
hi Identifier ctermfg=15 ctermbg=NONE cterm=NONE
hi Function ctermfg=11 ctermbg=NONE cterm=NONE

" Statements:
hi Statement ctermfg=3 ctermbg=NONE cterm=NONE

" Preprocessing:
hi PreProc ctermfg=10 ctermbg=NONE cterm=NONE

" Types:
hi Type ctermfg=3 ctermbg=NONE cterm=NONE

" Special:
hi Special ctermfg=10 ctermbg=NONE cterm=NONE
hi Tag ctermfg=3 ctermbg=NONE cterm=NONE
hi Delimiter ctermfg=3 ctermbg=NONE cterm=NONE
hi SpecialComment ctermfg=15 ctermbg=NONE cterm=bold,nocombine
hi Debug ctermfg=7 ctermbg=NONE cterm=italic,nocombine

" Other:
hi Underlined ctermfg=4 ctermbg=NONE cterm=underline,nocombine
hi Ignore ctermfg=0 ctermbg=NONE cterm=NONE
hi Error ctermfg=1 ctermbg=NONE cterm=NONE
hi Todo ctermfg=10 ctermbg=NONE cterm=italic,nocombine

" LSP:
hi LspReference ctermfg=NONE ctermbg=8 cterm=NONE
