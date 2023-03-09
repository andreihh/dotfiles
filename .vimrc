" ~/.vimrc

" This option stops Vim from behaving in a strongly Vi-compatible way. This must
" be the first line, because it changes other settings.
set nocompatible

" Install vim-plug for plugin management if not found.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Enable plugins via vim-plug.
call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug 'udalov/kotlin-vim'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'doums/darcula'
call plug#end()

" Enable automatic filetype detection and syntax highlighting.
filetype plugin indent on
syntax enable

" Encoding should always be UTF-8.
set encoding=utf-8
set fileencoding=utf-8

" Always assume unix-style files.
set fileformats=unix

" Highlight tabs and trailing whitespaces at the end of line.
set list listchars=tab:>-,trail:.,nbsp:~

" Store all backups, swap files and undo histories under /var/tmp (they should
" persist across reboots), or fallback to /tmp.
set backupdir=/var/tmp//,/tmp//
set directory=/var/tmp//,/tmp//
set undodir=/var/tmp//,/tmp//

" Use the system clipboard.
set clipboard=unnamedplus

" When set, highlights the current line.
set cursorline

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

" Allow backspacing over audoindent, line breaks and the start of insert.
set backspace=indent,eol,start

" When increasing/decreasing indent level, round to nearest multiple of
" shiftwidth.
set shiftround

" Copy indent from current line when starting a new line.
set autoindent

" Do smart autoindenting when starting a new line.
set smartindent

" Open new split panes to right and bottom, which feels more natural.
set splitbelow
set splitright

" When set to "dark", Vim wil try to use colors that look good on a dark
" background.
set background=dark

" Optionally enable a color scheme if the terminal supports at least 256 colors.
" The color scheme must be set after setting the background and enabling syntax.
if &t_Co >= 256
  colorscheme darcula
endif

" Set <Leader> to Space.
noremap <Space> <Nop>
let mapleader=" "

" Cancels search highlighting in normal mode.
nnoremap <Leader>/ :nohlsearch<CR>

" Copy until the end of the line. Consistent with D and C.
nnoremap Y y$

" Exit visual mode with q.
vnoremap q <Esc>

" Required in order to map the Alt key.
execute "set <A-s>=\es"
execute "set <A-v>=\ev"
execute "set <A-h>=\eh"
execute "set <A-j>=\ej"
execute "set <A-k>=\ek"
execute "set <A-l>=\el"
execute "set <A-H>=\eH"
execute "set <A-J>=\eJ"
execute "set <A-K>=\eK"
execute "set <A-L>=\eL"
execute "set <A-=>=\e="
execute "set <A-x>=\ex"
execute "set <A-q>=\eq"
execute "set <A-1>=\e1"

" Writes all buffers before navigating outside of Vim.
let g:tmux_navigator_save_on_switch=1

" If Vim is the zoomed pane, wraps around Vim instead of unzooming.
let g:tmux_navigator_disable_when_zoomed=1

" Panes should be resized in increments of 5.
let g:tmux_resizer_resize_count=5
let g:tmux_resizer_vertical_resize_count=5

" Define custom pane navigation and resizing mappings.
let g:tmux_navigator_no_mappings=1
let g:tmux_resizer_no_mappings=1

" Control and navigate panes using Alt:
" - Alt-s/v (split pane horizontally / vertically)
" - Alt-h/j/k/l (navigate panes)
" - Alt-H/J/K/L (resize panes)
" - Alt-= (resize all panes equally)
" - Alt-x (close pane)
" - Alt-q (close all panes except current one)
nnoremap <A-s> :split<CR>
nnoremap <A-v> :vsplit<CR>
nnoremap <silent> <A-h> :<C-U>TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :<C-U>TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :<C-U>TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :<C-U>TmuxNavigateRight<CR>
nnoremap <silent> <A-H> :<C-U>TmuxResizeLeft<CR>
nnoremap <silent> <A-J> :<C-U>TmuxResizeDown<CR>
nnoremap <silent> <A-K> :<C-U>TmuxResizeUp<CR>
nnoremap <silent> <A-L> :<C-U>TmuxResizeRight<CR>
nnoremap <A-=> <C-w>=
nnoremap <A-x> :quit<CR>
nnoremap <A-q> :only<CR>

" Focus the NERDTree window.
nnoremap <A-1> :NERDTreeFocus<CR>

" Show hidden files in the NERDTree window.
let NERDTreeShowHidden=1

" NERDTree shortcuts:
" - l (activate node)
" - h (jump to node's parent)
" - s/v (split node horizontally / vertically in same tab)
" - x/X (close node's parent / descendants)
" - q (close NERDTree)
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapJumpParent='h'
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapOpenVSplit='v'

" Fix indentation for whole file.
nnoremap <Leader>= gg=G

if !has('ide')
  " Trigger autocompletion automatically as soon as available.
  let g:ycm_auto_trigger=1
  let g:ycm_min_num_of_chars_for_completion=0

  " Autocomplete shortcuts:
  " - Ctrl-Space (trigger autocomplete)
  " - Tab/Shift-Tab (cycle options)
  " - Enter/Space (accept option)
  " - Esc (reject option, via native Vim command)
  let g:ycm_key_invoke_completion='<C-Space>'
  let g:ycm_key_list_select_completion=['<Tab>']
  let g:ycm_key_list_previous_completion=['<S-Tab>']
  let g:ycm_key_list_stop_completion=['<CR>']
  inoremap <expr> <Esc> pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
endif
