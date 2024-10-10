" JetBrains Darcula theme.
"
" Uses the 16 default ANSI colors and requires the terminal background to be
" ANSI black.

" Build on top of `darcula16plus` color scheme.
source $XDG_CONFIG_HOME/vim/colors/darcula16plus.vim

" Override the colorscheme name.
let colors_name = 'darcula16'

" Appearance:
hi LineNr ctermfg=7 ctermbg=8 cterm=NONE
hi CursorLineNr ctermfg=15 ctermbg=8 cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=8 cterm=NONE

" Menus:
hi PmenuSel ctermfg=15 ctermbg=8 cterm=inverse,nocombine
