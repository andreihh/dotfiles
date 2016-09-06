" This option stops Vim from behaving in a strongly Vi -compatible way.
set nocompatible

" Allow backspacing over audoindent, line breaks and the start of insert.
set backspace=eol,start

" Show the line and column number of the cursor position.
set ruler

" Show command in the last line of the screen.
set showcmd

" Show current mode.
set showmode

" Search options:
" - hlsearch: When there is a previous search pattern, highlight all its
" matches.
" - ignorecase: Ignore case in search patterns.
" - incsearch: While typing a search command, show where the pattern, as it was
" typed so far, matches.
set hlsearch ignorecase incsearch

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" When set to "dark", Vim wil try to use colors that look good on a dark
" background.
set background=dark

" When set, enables syntax highlighting.
syntax enable

" When set, highlights the current line.
set cursorline

" When wrap is set to off lines will not wrap.
set nowrap

" Highlight when you exceed the 80 column limit.
set colorcolumn=81

" Highlight tabs and trailing whitespaces at the end of line.
set list listchars=tab:>-,trail:.

" Print relative line numbers in front of each line.
set relativenumber

" Print the absolute line number in front of the current line.
set number

" Use the appropriate number of spaces to insert a <Tab>.
set expandtab

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4

" When increasing/decreasing indent level, round to nearest multiple of
" shiftwidth.
set shiftround

" Copy indent from current line when starting a new line.
set autoindent

" Do smart autoindenting when starting a new line.
set smartindent

" Sets the terminal to support 256 colors. This is required to support color
" themes.
set t_Co=256

" Sets the colorscheme to darcula, which can be found here:
" https://www.github.com/blueshirts/darcula
" colorscheme darcula

" Make command
:set makeprg=make\ %<\ LDLIBS=\"-lm\"\ CFLAGS=\"-Wall\ -O2\ -static\"\ CPPFLAGS=\"-Wall\ -O2\ -static\ -std=c++0x\"

" Mappings
map <F7> <ESC>:w<CR>:make<CR>
map <F8> <ESC>:!time ./%<<CR>
map <F9> <ESC>:w<CR>:make<CR>:!time ./%<<CR>

imap <F7> <ESC>:w<CR>:make<CR>
imap <F8> <ESC>:!time ./%<<CR>
imap <F9> <ESC>:w<CR>:make<CR>:!time ./%<<CR>

" Curly bracket autocomplete
" inoremap {<CR> {<CR>}<ESC>O
" inoremap { {}<ESC>i " Optional

" Parens autocomplete
inoremap ( ()<ESC>i

" Square brackets autocomplete
inoremap [ []<ESC>i

" Optionally, Ctrl-Space autocomplete (as in IntelliJ)
" inoremap <C-SPACE> <C-N>

" Tab autocomplete
function! TabComplete()
    if col('.') > 1 && strpart(getline('.'), col('.')-2, 3) =~ '^\w'
        return "\<C-N>"
    else
        return "\<TAB>"
endfunction
set completeopt=longest,menu
inoremap <TAB> <C-R>=TabComplete()<CR>
