-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- General:
--  - <esc> = clear search highlights
--  - u = [u]ndo
--  - <C-r> = [r]edo
--  - g + 1..9 = [g]o to tab 1..9
--  - gj / gk = [g]o to previous / next location
--  - gx = [g]o to URI with e[x]ternal system handler
--  - [q / ]q / [Q / ]Q = jump to previous / next / first / last [q]uickfix
--  - [c / ]c / [C / ]C = jump to previous / next / first / last [c]hanged hunk
--  - <leader><leader> = trigger Flash
--  - <C-\> = show keymap help
-- Window:
--  - <C-s/v/t/z/x/w> = perform window action
--  - <C-h/j/k/l> = navigate panes across Vim and `tmux`
--  - <M-h/j/k/l/=> = resize panes across Vim and `tmux`
--  - Q = [q]uit all
-- Terminal:
--  - t = open [t]erminal
--  - <C-e> = [e]xit terminal mode
-- Oil:
--  - <C-o> = [o]pen / refresh file explorer
--  - gf = [g]o to [f]ile / [f]older
--  - gp = [g]o to [p]arent directory
--  - gx = [g]o to URI with e[x]ternal system handler
--  - gh = toggle [g]o to [h]idden files
--  - <esc> = [e]xit
--  - <C-\> = show keymap help
-- Telescope:
--  - <C-j/k> = select next / previous item
--  - <C-h> = [h]op
--  - <C-u/d> = scroll preview [u]p / [d]own
--  - <C-o/s/v/t> = open selected item in window
--  - <esc> = [e]xit insert / normal mode
--  - <C-e> = [e]xit
--  - <C-\> = show keymap help
--  - s + p/h/k/f/r/c/g/d/w// = [s]earch with picker
--  - ss = [s]earch [s]essions
--    - <C-d> = [d]elete selected session
-- Completion:
--  - <C-space> = trigger completion
--  - <C-j/k> = select next / previous item
--  - <C-l/h> = jump to next / previous in snippet
--  - <C-u/d> = scroll documentation [u]p / [d]own
--  - <tab> = accept selected item
--  - <C-e> = [e]xit
-- LSP:
--  - g + d/D/i/r = perform code navigation
--  - [d / ]d / [w / ]w / [e / ]e = jump to previous / next diagnostic severity
--  - <leader>h = show [h]elp
--    - <leader>h = focus [h]elp
--    - q = [q]uit help if focused
--  - <C-h> = show [s]ignature help
--  - <leader> + f/r/a/H/c/-/=/l/L = perform code action

local function map(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function noremap(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.noremap = true
  map(mode, lhs, rhs, desc, opts)
end

noremap("n", "<esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")
noremap("c", "<C-j>", "<C-n>", "Select the next item")
noremap("c", "<C-k>", "<C-p>", "Select the previous item")

noremap("n", "<C-s>", "<cmd>split<CR>", "[S]plit window horizontally")
noremap("n", "<C-v>", "<cmd>vsplit<CR>", "Split window [V]ertically")
noremap("n", "<C-t>", "<cmd>tabedit %<CR>", "New [T]ab")
noremap("n", "<C-z>", "<cmd>only<CR>", "Close all windows except current one")
noremap("n", "<C-x>", "<cmd>quit<CR>", "Close window")
noremap("n", "<C-w>", "<cmd>tabclose<CR>", "Close tab")
noremap("n", "<M-=>", "<C-w>=", "Resize all windows equally")
noremap("n", "Q", "<cmd>quitall<CR>", "Quit")

noremap("n", "t", "<cmd>terminal<CR>", "Open [T]erminal")
noremap("t", "<C-e>", "<C-\\><C-n>", "[E]xit terminal mode")

for i = 1, 9 do
  noremap("n", "g" .. i, i .. "gt", "[G]o to tab number [" .. i .. "]")
end

noremap("n", "gj", "<C-o>", "[G]o to previous location")
noremap("n", "gk", "<C-i>", "[G]o to next location")

-- NOTE: This is not Goto Definition, this is Goto Declaration.
--  For example, in C this would take you to the header.
noremap("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

noremap("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, "Jump to previous [E]rror")

noremap("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, "Jump to next [E]rror")

noremap("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, "Jump to previous [W]arning")

noremap("n", "]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, "Jump to next [W]arning")

noremap("n", "<leader>h", vim.lsp.buf.hover, "Show [H]elp")
noremap("i", "<C-s>", vim.lsp.buf.signature_help, "Show [S]ignature help")
noremap("n", "<leader>H", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Toggle inlay [H]ints")

noremap("n", "<leader>f", "za", "Toggle [F]old under cursor")
noremap("n", "<leader>r", vim.lsp.buf.rename, "[R]ename")
noremap("n", "<leader>a", vim.lsp.buf.code_action, "Code [A]ction")
noremap("n", "<leader>L", vim.diagnostic.reset, "Clear diagnostics")
