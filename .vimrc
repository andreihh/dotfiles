" .vimrc

" Enable the pathogen plugin for plugin management. Keep this declaration at the
" top to avoid problems.
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" This option stops Vim from behaving in a strongly Vi -compatible way.
set nocompatible

" When set to "dark", Vim wil try to use colors that look good on a dark
" background.
set background=dark

" When set, highlights the current line.
set cursorline

" Highlight when you exceed the 80 column limit.
set colorcolumn=81

" When wrap is set to off lines will not wrap.
set nowrap

" Show the line and column number of the cursor position.
set ruler

" Show command in the last line of the screen.
set showcmd

" Show current mode.
set showmode

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Print relative line numbers in front of each line.
set relativenumber

" Print the absolute line number in front of the current line.
set number

" Search options:
" - hlsearch: When there is a previous search pattern, highlight all its
" matches.
" - ignorecase: Ignore case in search patterns.
" - incsearch: While typing a search command, show where the pattern, as it was
" typed so far, matches.
set hlsearch ignorecase incsearch

" When set, enables syntax highlighting.
syntax enable

" Allow backspacing over audoindent, line breaks and the start of insert.
set backspace=indent,eol,start

" Use the appropriate number of spaces to insert a <Tab>.
set expandtab

" When increasing/decreasing indent level, round to nearest multiple of
" shiftwidth.
set shiftround

" Copy indent from current line when starting a new line.
set autoindent

" Do smart autoindenting when starting a new line.
set smartindent

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4

" Always assume unix-style files.
set fileformats=unix

" Highlight tabs and trailing whitespaces at the end of line.
set list listchars=tab:>-,trail:.,nbsp:~

" Open new split panes to right and bottom, which feels more natural.
set splitbelow
set splitright

" Sets the terminal to support 256 colors. This is required to support color
" themes.
" set t_Co=256

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
inoremap {<CR> {<CR>}<ESC>O
" inoremap { {}<ESC>i " Optional

" Parens autocomplete
inoremap ( ()<ESC>i

" Square brackets autocomplete
inoremap [ []<ESC>i

" Tab autocomplete
function! CleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<TAB>"
    else
        return "\<C-N>"
endfunction
set completeopt=longest,menu
inoremap <TAB> <C-R>=TabComplete()<CR>
