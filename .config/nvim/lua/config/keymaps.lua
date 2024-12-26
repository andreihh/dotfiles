-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- General:
--  - L = [L]azy plugin manager
--  - S = [s]ave buffer
--  - Q = [q]uit
--  - <esc> = clear search highlights
--  - u = [u]ndo
--  - <C-r> = [r]edo
--  - <C-u/d> = jump half page [u]p / [d]own
--  - g1 / ... / g9 = [g]o to tab 1..9
--  - gj / gk = [g]o to previous / next location
--  - gf = [g]o to [f]ile under cursor / selected [f]ile
--  - gx = [g]o to URI with e[x]ternal system handler
--  - [q / ]q / [Q / ]Q = jump to previous / next / first / last [q]uickfix
--  - { / } = jump to previous / next blank line
--  - f/F/t/T/;/, = enhanced [F]lash motions
--  - <C-f> = trigger multi-window [F]lash
--  - <C-\> = show keymap help
-- Window:
--  - <C-s/v/t/z/x/w> = perform window action
--  - <C-h/j/k/l> = navigate panes across Vim and `tmux`
--  - <M-h/j/k/l/=> = resize panes across Vim and `tmux`
-- Terminal:
--  - X = open terminal
--  - <C-e> = [e]xit terminal mode
-- Session:
--  - ss = [s]ession [s]earch
--  - sS = [s]ession [s]ave
--  - sD = [s]ession [d]elete
-- Search:
--  - s + p/h/k/f/r/b/c/g/d/w/./:// = [s]earch with picker
--  - <C-j/k> = select next / previous item
--  - <C-f> = [f]lash jump
--  - <C-u/d> = scroll preview [u]p / [d]own
--  - <C-l/p> = toggle [l]ine / [p]review wrapping for long lines
--  - <tab> = accept selected / toggled items
--  - <S-tab> = toggle selected item
--  - <C-o/s/v/t> = open selected item in window
--  - <esc> = exit
--  - <C-\> = show keymap help
-- Explorer:
--  - <C-o> = [o]pen / refresh file explorer
--  - gf = [g]o to [f]ile / [f]older
--  - gp = [g]o to [p]arent directory
--  - gx = [g]o to URI with e[x]ternal system handler
--  - gh = toggle [g]o to [h]idden files
--  - <C-e> = [e]xit
--  - <C-\> = show keymap help
-- Input:
--  - <tab> = accept input
--  - <esc> = exit from insert / visual / normal mode
--  - <C-e> = [e]xit
-- Completion:
--  - <C-space> = trigger completion
--  - <C-j/k> = select next / previus item
--  - <C-h/l> = jump to previous / next snippet placeholder
--  - <C-u/d> = scroll documentation [u]p / [d]own
--  - <tab> = accept selected item
--  - <C-e> = [e]xit
-- VCS:
--  - [c / ]c / [C / ]C = jump to previous / next / first / last [c]hanged hunk
--  - <leader>b / <leader>g = open Git [b]lame / Lazy[G]it
--    - q = [q]uit
-- LSP:
--  - g + d/D/i/r = perform code navigation
--  - [r / ]r = jump to previous / next [r]eference
--  - [d / ]d / [w / ]w / [e / ]e = jump to previous / next diagnostic severity
--  - <leader>h / <C-s> / <leader>D = show [h]elp / [s]ignature / [d]iagnostic
--    - <leader>h / <C-s> / <leader>D = focus float
--    - q = [q]uit float if focused
--  - <leader> + =/-/f/c/r/a/l/L/H/T = perform code action
-- Treesitter:
--  - [f / ]f / [t / ]t = jump to previous / next start of [f]unction / [t]ype
--  - [F / ]F / [T / ]T = jump to previous / next end of [f]unction / [t]ype
--  - af / at / as = [a]round [f]unction / [t]ype / [s]cope
--  - if / it = [i]nside [f]unction / [t]ype

-- Set `<space>` as the leader key.
--  See `:help mapleader`
--  NOTE: Must happen before setting any keymaps or loading any plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true })
end

map("n", "L", "<cmd>Lazy<CR>", "Launch [L]azy plugin manager")
map("n", "S", "<cmd>write<CR>", "[S]ave buffer")
map("n", "Q", "<cmd>quitall<CR>", "[Q]uit")
map("n", "<esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")
map("n", "s", "<nop>", "Disable [S]ubstitute to allow search chaining")

map("n", "<C-s>", "<cmd>split<CR>", "[S]plit window horizontally")
map("n", "<C-v>", "<cmd>vsplit<CR>", "Split window [V]ertically")
map("n", "<C-t>", "<cmd>tabedit %<CR>", "New [T]ab")
map("n", "<C-x>", "<cmd>quit<CR>", "Close window")
map("n", "<C-w>", "<cmd>tabclose<CR>", "Close tab")
map("n", "<M-=>", "<C-w>=", "Resize all windows equally")

map("n", "X", "<cmd>terminal<CR>", "Open terminal")
map("t", "<C-e>", "<C-\\><C-n>", "[E]xit terminal mode")

for i = 1, 9 do
  map("n", "g" .. i, i .. "gt", "[G]oto tab " .. i)
end

map("n", "gj", "<C-o>", "[G]oto previous location")
map("n", "gk", "<C-i>", "[G]oto next location")

map("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, "Jump to previous [E]rror")

map("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, "Jump to next [E]rror")

map("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, "Jump to previous [W]arning")

map("n", "]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, "Jump to next [W]arning")

map("n", "<leader>h", vim.lsp.buf.hover, "Show [H]elp")
map("i", "<C-s>", vim.lsp.buf.signature_help, "Show [S]ignature help")
map("n", "<leader>D", vim.diagnostic.open_float, "Show [D]iagnostic")

map({ "n", "x" }, "<leader>-", "<cmd>:normal gcc<CR>", "Toggle comment")
map("n", "<leader>f", "za", "Toggle [F]old under cursor")
map("n", "<leader>r", vim.lsp.buf.rename, "[R]ename")
