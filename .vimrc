" ~/.vimrc
"
" Requires Vim9+ and `ripgrep`.

" Install `vim-plug` for plugin management if not found. Manage with the
" following commands:
" - :PlugInstall
" - :PlugUpdate
" - :PlugClean
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Enable plugins via vim-plug.
call plug#begin()
Plug 'editorconfig/editorconfig-vim'  " File encodings, indentation, etc.
Plug 'tpope/vim-sensible'  " Sensible settings.
Plug 'tpope/vim-surround'  " Better surround motions.
Plug 'easymotion/vim-easymotion'  " Better navigation motions.
Plug 'airblade/vim-rooter'  " Auto-cd to project root if any.
Plug 'mhinz/vim-signify'  " VCS gutter signs for changed lines.
Plug 'doums/darcula'  " IntelliJ dark color scheme.
Plug 'udalov/kotlin-vim'  " Kotlin syntax highlight.
" Better `tmux` integration.
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
" Fuzzy searching.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Vim LSP plugins.
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
" Code formatting.
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'google/vim-codefmt'
call plug#end()

" Store all backups, swap files and undo histories under /var/tmp (they should
" persist across reboots), or fallback to /tmp.
set backupdir=/var/tmp//,/tmp//
set directory=/var/tmp//,/tmp//
set undodir=/var/tmp//,/tmp//

" Use the system clipboard.
set clipboard=unnamedplus

" Always assume unix-style files.
set fileformats=unix

" When wrap is set to off lines will not wrap.
set nowrap

" When set, highlights the current line.
set cursorline

" Print relative line numbers in front of each line.
set relativenumber

" Print the absolute line number in front of the current line.
set number

" Highlight tabs, trailing whitespaces, and overrunning lines.
set list

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Show current mode.
set showmode

" Show command in the last line of the screen.
set showcmd

" When there is a previous search pattern, highlight all its matches.
set hlsearch

" Ignore case in search patterns.
set ignorecase

" When increasing / decreasing indent level, round to nearest multiple of
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

" Make Esc more responsive.
set timeout ttimeoutlen=10

" Optionally enable a color scheme if the terminal supports at least 256 colors.
" The color scheme must be set after setting the background and enabling syntax.
if &t_Co >= 256
  colorscheme darcula
endif

" Copy until the end of the line. Consistent with D and C.
nnoremap Y y$

" Exit visual mode with q.
vnoremap q <esc>

" Set <leader> and macro autocompletion keys. Must not have surrounding spaces.
noremap <space> <nop>
let mapleader=" "
set wildcharm=<C-Z>

" Navigation actions:
" - gj / gk (jump to previous / next location)
" - gf (jump to file under cursor)
" - go (open the URI under cursor / selected URI)
" - <leader><leader> + motion (trigger EasyMotion)
" - [c / ]c / [C / ]C (jump to previous / next / first / last changed hunk)
nnoremap gj <C-o>
nnoremap gk <C-i>
map go gx

" Cancels search highlighting in normal mode.
nnoremap <leader>/ :nohlsearch<CR>

" Fuzzy searching shortcuts:
" - <leader>o (search files)
" - <leader>s (search everywhere)
" - <leader>c (search uncommitted Git files)
" - Ctrl-n/p (cycle options)
" - Enter (open option in current buffer)
" - Ctrl-t (open option in new tab)
" - Ctrl-s/v (open option in horizontal / vertical split)
" - Ctrl-c / Esc (cancel)
nnoremap <leader>o :Files<CR>
nnoremap <leader>s :Rg<CR>
nnoremap <leader>c :GFiles?<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

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

" Required to map the Alt key.
for key in "123456789tnsvhjklHJKL=wzxXq"
  execute "set <A-" . key . ">=\e" . key
endfor
execute "set <A-CR>=\e\<CR>"

" Control and navigate panes and tabs using Alt:
" - Alt-1/2/.../9 (switch tabs)
" - Alt-t (new tab)
" - Alt-n (new file in current buffer)
" - Alt-s/v (split pane horizontally / vertically)
" - Alt-h/j/k/l (navigate panes)
" - Alt-H/J/K/L (resize panes)
" - Alt-= (resize all panes equally)
" - Alt-w (break pane into a new tab)
" - Alt-z (close all panes except current one)
" - Alt-x (close pane)
" - Alt-X (close all panes and tabs)
" - Alt-q (toggle quickfix pane)
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-t> :tabnew<CR>
nnoremap <A-n> :edit %:p:h<C-Z>
nnoremap <A-s> :split<CR>
nnoremap <A-v> :vsplit<CR>
nnoremap <silent> <A-h> :<C-u>TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :<C-u>TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :<C-u>TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :<C-u>TmuxNavigateRight<CR>
nnoremap <silent> <A-H> :<C-u>TmuxResizeLeft<CR>
nnoremap <silent> <A-J> :<C-u>TmuxResizeDown<CR>
nnoremap <silent> <A-K> :<C-u>TmuxResizeUp<CR>
nnoremap <silent> <A-L> :<C-u>TmuxResizeRight<CR>
nnoremap <silent> <A-=> <C-w>=
nnoremap <A-w> <C-w>T
nnoremap <A-z> :only<CR>
nnoremap <A-x> :quit<CR>
nnoremap <A-X> :qa<CR>
nnoremap <expr> <A-q> empty(filter(getwininfo(), 'v:val.quickfix'))
  \ ? ":copen\<CR>" : ":cclose\<CR>"

" Show float diagnostics only on cursor hover.
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0

" Code navigation actions.
nmap gd <plug>(lsp-definition)
nmap gi <plug>(lsp-implementation)
nmap gt <plug>(lsp-type-definition)

" Code inspection actions.
nmap <leader>f <plug>(lsp-references)
nmap <leader>h <plug>(lsp-hover)
nmap [w <plug>(lsp-previous-diagnostic)
nmap ]w <plug>(lsp-next-diagnostic)
nmap [e <plug>(lsp-previous-error)
nmap ]e <plug>(lsp-next-error

" Code formatting actions.
nnoremap <leader>= :FormatCode<CR>
vnoremap <leader>= :FormatLines<CR>

" Code actions shortcuts:
" - <leader>r (rename)
" - <leader>a (trigger code actions)
" - Ctrl-n/p (cycle options)
" - Enter (accept option)
" - Ctrl-c / Esc (cancel)
nmap <leader>r <plug>(lsp-rename)
nmap <leader>a <plug>(lsp-code-action-float)

" Autocomplete shortcuts:
" - Ctrl-Space (trigger autocomplete)
" - Ctrl-n/p (cycle options)
" - Ctrl-c (reject option)
imap <C-@> <C-space>
imap <C-space> <C-x><C-o>
imap <C-c> <C-e>

" Enable default autocompletion.
set omnifunc=syntaxcomplete#Complete

function! s:on_lsp_buffer_enabled() abort
  " Enable LSP autocompletion.
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  " Code completion actions.
  imap <C-space> <plug>(asyncomplete_force_refresh)
endfunction

augroup lsp_install
  au!
  " Call s:on_lsp_buffer_enabled only for languages that have the server
  " registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
