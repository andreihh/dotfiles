" settings.vim
"
" Common settings and key mappings. Assumes the following plugins are loaded:
" - `editorconfig-vim`
" - `vim-sensible`
" - `vim-surround`
" - `vim-commentary`
" - `vim-signify`
" - `vim-rooter`
" - `vim-tmux-navigator`
" - `better-vim-tmux-resizer`

" Use the system clipboard.
set clipboard=unnamedplus

" Always assume Unix-style files.
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

" Set custom status line.
set statusline=[%f]%([%M%R%H%W]%)%q%=[\ %l,%c\ \|\ %p%%\ \|\ %LL\ ]

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

" Don't use characters for vertical split delimiter.
set fillchars+=vert:\ ,

" Enable sign column.
set signcolumn=yes

" When set to "dark", Vim wil try to use colors that look good on a dark
" background.
set background=dark

" Optionally enable a color scheme if the terminal supports at least 16 colors.
" The color scheme must be set after setting the background and enabling syntax.
if &t_Co >= 16
  " Use `darcula16plus` if the terminal has a 17 color palette (the 16 default
  " ANSI colors and a background darker than ANSI black) and `darcula16`
  " otherwise.
  colorscheme darcula16plus
  "colorscheme darcula16
endif

" Make Esc more responsive.
set timeout ttimeoutlen=10

" Copy until the end of the line. Consistent with D and C.
nnoremap Y y$

" Exit visual mode with q.
vnoremap q <esc>

" Cancels search highlighting in normal mode.
nnoremap ' :nohlsearch<CR>

" Set <leader> and macro autocompletion keys. Must not have surrounding spaces.
noremap <space> <nop>
let mapleader=" "
set wildcharm=<C-z>

" Writes all buffers before navigating outside of Vim.
let g:tmux_navigator_save_on_switch=1

" If Vim is the zoomed pane, wraps around Vim instead of unzooming.
let g:tmux_navigator_disable_when_zoomed=1

" Panes should be resized in increments of 5.
let g:tmux_resizer_resize_count=5
let g:tmux_resizer_vertical_resize_count=5

" Required to map the Alt key.
for key in "hjkl="
  execute "set <M-" . key . ">=\e" . key
endfor

" Control and navigate panes:
" - Ctrl-o (new file in current buffer)
" - Ctrl-t (new tab)
" - Ctrl-s/v (split pane horizontally / vertically)
" - Ctrl-h/j/k/l (navigate panes)
" - Alt-h/j/k/l (resize panes)
" - Alt-= (resize all panes equally)
" - Ctrl-z (close all panes except current one)
" - Ctrl-x (close pane)
" - Ctrl-w (close tab)
nnoremap <C-o> :edit %:p:h<C-z>
nnoremap <C-t> :tabedit %<CR>
nnoremap <C-s> :split<CR>
nnoremap <C-v> :vsplit<CR>
nnoremap <M-=> <C-w>=
nnoremap <C-z> :only<CR>
nnoremap <C-x> :quit<CR>
nnoremap <C-w> :tabclose<CR>

" Navigation actions:
" - g1 /g2 / ... / g9 (go to tab)
" - gj / gk (go to previous / next location)
" - gf (go to file under cursor or to selected file)
" - go (open URI under cursor or selected URI)
" - [c / ]c / [C / ]C (go to previous / next / first / last changed hunk)
" - [m / ]m (go to previous / next start of Java-style method or class)
" - [M / ]M (go to previous / next end of Java-style method or class)
" - { / } (go to previous / next blank line)
" - Ctrl-u/d (go half page up / down)
nnoremap g1 1gt
nnoremap g2 2gt
nnoremap g3 3gt
nnoremap g4 4gt
nnoremap g5 5gt
nnoremap g6 6gt
nnoremap g7 7gt
nnoremap g8 8gt
nnoremap g9 9gt
nnoremap gj <C-o>
nnoremap gk <C-i>
map go gx

" Code commenting:
" - <leader>c (comment line or selected range)
noremap <leader>c :Commentary<CR>

" Autocomplete shortcuts:
" - Ctrl-Space (trigger autocomplete)
" - Ctrl-n/p (cycle options)
" - Ctrl-y (accept option)
" - Ctrl-e (cancel)
imap <C-@> <C-space>
imap <C-space> <C-x><C-o>

" Enable default autocompletion.
set omnifunc=syntaxcomplete#Complete
