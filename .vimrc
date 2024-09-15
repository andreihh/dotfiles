" ~/.vimrc
"
" Requires Vim9+ and Ag.

" Install vim-plug for plugin management if not found.
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
Plug 'mhinz/vim-signify'  " VCS gutter signs for changed lines.
Plug 'doums/darcula'  " IntelliJ dark color scheme.
Plug 'udalov/kotlin-vim'  " Kotlin syntax highlight.
" Better TMUX integration.
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
" Fuzzy search with fzf and ag.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Vim LSP plugins.
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
call plug#end()

" Store all backups, swap files and undo histories under /var/tmp (they should
" persist across reboots), or fallback to /tmp.
set backupdir=/var/tmp//,/tmp//
set directory=/var/tmp//,/tmp//
set undodir=/var/tmp//,/tmp//

" Use the system clipboard.
set clipboard=unnamedplus

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

" Optionally enable a color scheme if the terminal supports at least 256 colors.
" The color scheme must be set after setting the background and enabling syntax.
if &t_Co >= 256
  colorscheme darcula
endif

" Copy until the end of the line. Consistent with D and C.
nnoremap Y y$

" Exit visual mode with q.
vnoremap q <esc>

" Set <leader> to Space.
noremap <space> <nop>
let mapleader=" "

" Cancels search highlighting in normal mode.
nnoremap <leader>/ :nohlsearch<CR>

" Fuzzy search with fzf shortcuts:
" - <leader>-s (search file paths)
" - <leader>-S (search file contents)
" - Ctrl-n/p (cycle options)
" - Enter (open option in this buffer)
" - Ctrl-t (open option in new tab)
" - Ctrl-s/v (open option in horizontal / vertical split)
" - Esc (cancel search)
nnoremap <leader>s :Files<CR>
nnoremap <leader>S :Ag<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Jump to previous / next location.
nnoremap <leader>j <C-o>
nnoremap <leader>k <C-i>

" Jump to next / previous changed hunk.
nnoremap <leader>c <plug>(signify-next-hunk)
nnoremap <leader>C <plug>(signify-prev-hunk)

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

" File explorer should use tree style and disable the netrw banner.
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" File explorer shortcuts:
" - R (refresh file explorer)
" - c (change root to selected directory)
" - u (change root to parent directory)
" - j/k (navigate down / up)
" - l (activate node)
" - r (rename node)
" - d (create new directory)
" - f (create new file)
" - x (delete node)
au filetype netrw map <buffer> R <C-l>
au filetype netrw map <buffer> c gn
au filetype netrw map <buffer> u -
au filetype netrw map <buffer> l <CR>
au filetype netrw map <buffer> r R
au filetype netrw map <buffer> f %
au filetype netrw map <buffer> x D

" Required to map the Alt key.
for key in "n123456789svhjklHJKL=bwzxqe"
  execute "set <A-" . key . ">=\e" . key
endfor
execute "set <A-CR>=\e\<CR>"

" Control and navigate panes and tabs using Alt:
" - Alt-n (new tab)
" - Alt-1/2/.../9 (switch tabs)
" - H/L (switch to previous / next tab)
" - Alt-s/v (split pane horizontally / vertically)
" - Alt-h/j/k/l (navigate panes)
" - Alt-H/J/K/L (resize panes)
" - Alt-= (resize all panes equally)
" - Alt-b (open file explorer)
" - Alt-w (break pane into a new tab)
" - Alt-z (close all panes except current one)
" - Alt-x (close pane)
" - Alt-q (focus quickfix pane)
" - q (close quickfix pane)
nnoremap <A-n> :tabnew<CR>
nnoremap <A-s> :split<CR>
nnoremap <A-v> :vsplit<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <silent> <A-h> :<C-u>TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :<C-u>TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :<C-u>TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :<C-u>TmuxNavigateRight<CR>
nnoremap <silent> <A-H> :<C-u>TmuxResizeLeft<CR>
nnoremap <silent> <A-J> :<C-u>TmuxResizeDown<CR>
nnoremap <silent> <A-K> :<C-u>TmuxResizeUp<CR>
nnoremap <silent> <A-L> :<C-u>TmuxResizeRight<CR>
nnoremap <silent> <A-=> <C-w>=
nnoremap <A-b> :Explore<CR>
nnoremap <A-w> <C-w>T
nnoremap <A-z> :only<CR>
nnoremap <A-x> :quit<CR>
nnoremap <A-q> :copen<CR>
nnoremap <expr> q empty(filter(getwininfo(), 'v:val.quickfix'))
  \ ? "q" : ":cclose\<CR>"

" Autocomplete shortcuts:
" - Ctrl-Space (trigger autocomplete)
" - Ctrl-n/p (cycle options)
" - Ctrl-y (accept option)
" - Ctrl-e (reject option)
imap <C-@> <C-space>
imap <C-space> <C-x><C-o>

" Alternative autocomplete shortcuts:
" - Tab/Shift-Tab (cycle options)
" - Enter (accept option)
" - Alt-e (reject option)
"inoremap <expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
"inoremap <expr> <S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
"inoremap <expr> <A-e> pumvisible() ? "\<C-e>" : "\<A-e>"

" Enable default autocompletion.
set omnifunc=syntaxcomplete#Complete

" Show float diagnostics only on cursor hover.
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0

function! s:on_lsp_buffer_enabled() abort
  " Enable LSP autocompletion.
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  " Code completion actions.
  imap <C-space> <plug>(asyncomplete_force_refresh)
  "inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

  " Code navigation actions.
  nmap <buffer> <leader>d <plug>(lsp-definition)
  nmap <buffer> <leader>i <plug>(lsp-implementation)
  nmap <buffer> <leader>t <plug>(lsp-type-definition)

  " Code inspection actions.
  nmap <buffer> <leader>f <plug>(lsp-references)
  nmap <buffer> <leader>q <plug>(lsp-hover)
  nmap <buffer> <leader>w <plug>(lsp-next-diagnostic)
  nmap <buffer> <leader>W <plug>(lsp-previous-diagnostic)
  nmap <buffer> <leader>e <plug>(lsp-next-error)
  nmap <buffer> <leader>E <plug>(lsp-previous-error)

  " Code manipulation actions.
  nmap <buffer> <leader>r <plug>(lsp-rename)
  nmap <buffer> <leader>= <plug>(lsp-document-format)

  " Code action shortcuts:
  " - Alt-Enter (trigger code actions float)
  " - Ctrl-n/p (cycle options)
  " - Enter (accept option)
  " - Esc (close float)
  nmap <buffer> <A-CR> <plug>(lsp-code-action-float)

  let g:lsp_format_sync_timeout = 1000
endfunction

augroup lsp_install
  au!
  " Call s:on_lsp_buffer_enabled only for languages that have the server
  " registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
