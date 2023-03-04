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
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
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

" Use the system clipboard. This will allow yanking and pasting in Vim playing
" nice with Ctrl-C and Ctrl-V in external apps.
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

" Exit visual mode with q.
vnoremap q <Esc>

" Copy until the end of the line. Consistent with D and C.
nnoremap Y y$

" Cancels search highlighting in normal mode.
nnoremap <Leader>/ :nohlsearch<CR><Esc>

" Control tabs and panes using <Leader>:
" - <Leader> + n (open tab)
" - <Leader> + x (close pane)
" - <Leader> + h/l (navigate tabs)
" - <Leader> + <Esc> (close all panes except current one)
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>x :close<CR>
nnoremap <Leader>h :tabnext<CR>
nnoremap <Leader>l :tabprev<CR>
nnoremap <Leader><Esc> :only<CR>

" Navigate panes using <Leader> instead of Ctrl:
" - <Leader>w + s/v (split)
" - <Leader>w + h/j/k/l (navigate)
" - <Leader>w + w (cycle)
" - <Leader>w + H/J/K/L (resize)
nnoremap <Leader>w <C-w>
nnoremap <Leader>wH :vertical resize -5<CR>
nnoremap <Leader>wJ :resize +5<CR>
nnoremap <Leader>wK :resize -5<CR>
nnoremap <Leader>wL :vertical resize +5<CR>

" Fix indentation for whole file.
nnoremap <Leader>= gg=G

" Focus the NERDTree window.
nnoremap <Leader>1 :NERDTreeFocus<CR>

" Show hidden files in the NERDTree window.
let NERDTreeShowHidden=1

if !has('ide')
  " Ctrl-Space should trigger auto-completion.
  inoremap <C-Space> <C-N>

  " YouCompleteMe should always popup completion menu.
  let g:ycm_min_num_of_chars_for_completion=0

  " Enter accepts autocomplete option.
  inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<Esc>a" : "\<CR>"

  " Esc closes autocomplete window and exits insert mode.
  inoremap <expr> <Esc> pumvisible() ? "\<C-E>\<Esc>" : "\<Esc>"

  " Make command
  :set makeprg=make\ %<\ LDLIBS=\"-lm\"\ CFLAGS=\"-Wall\ -O2\ -static\ -std=c11\"\ CPPFLAGS=\"-Wall\ -O2\ -static\ -std=c++0x\"

  " Mappings
  map <F7> <Esc>:w<CR>:make<CR>
  map <F8> <Esc>:!time ./%<<CR>
  map <F9> <Esc>:w<CR>:make<CR>:!time ./%<<CR>

  imap <F7> <Esc>:w<CR>:make<CR>
  imap <F8> <Esc>:!time ./%<<CR>
  imap <F9> <Esc>:w<CR>:make<CR>:!time ./%<<CR>
endif
