-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- General:
--  - <esc> = clear search highlights
--  - <C-e> = [e]xit terminal mode
--  - u = [u]ndo
--  - <C-r> = [r]edo
--  - g + 1..9 = [g]o to tab 1..9
--  - gj / gk = [g]o to previous / next location
--  - gx = [g]o to URI with e[x]ternal system handler
--  - [c / ]c = jump to previous / next [c]hanged hunk
--  - <C-\> = show keymap help
-- Window:
--  - <C-s/v/t/z/x/w> = perform window action
--  - <C-h/j/k/l> = navigate panes across Vim and `tmux`
--  - <M-h/j/k/l/=> = resize panes across Vim and `tmux`
-- Explorer:
--  - gf = [g]o to [f]ile / [f]older
--  - gp = [g]o to [p]arent directory
--  - gx = [g]o to URI with e[x]ternal system handler
--  - th = [t]oggle [h]idden files
--  - <C-l> = re[l]oad
--  - <C-e> = [e]xit
--  - <C-\> = show keymap help
--  - <C-o> = [o]pen explorer in current buffer's directory
-- Telescope:
--  - <C-n/p> = select [n]ext / [p]revious option
--  - <C-o/s/v/t> = open selected option in window
--  - <C-u/d> = scroll preview [u]p / [d]own
--  - <C-e> = [e]xit
--  - <C-h> = trigger [h]op
--  - <C-\> = show keymap help
--  - s + s/h/k/v/f/r/c/g/d/q/w// = [s]earch with picker
--  - s + p = [s]earch [p]roject session
--    - <C-d> = [d]elete session
-- Completion:
--  - <C-n/p> = select [n]ext / [p]revious option
--  - <C-u/d> = scroll documentation window [u]p / [d]own
--  - <C-l/h> = jump in snippet
--  - <tab> = accept selected option
--  - <C-e> = [e]xit
--  - <C-space> = trigger completion
-- LSP:
--  - g + d/D/i/r = perform code navigation
--  - [d / ]d / [w / ]w / [e / ]e = jump to previous / next diagnostic severity
--  - <leader>h = show [h]elp
--    - <leader>h = focus [h]elp
--    - q = [q]uit help if focused
--  - <C-h> = show [s]ignature help
--  - <leader> + f/r/a/h/H/c/=/l/L = perform code action

-- Set <C-z> as macro autocompletion key.
vim.opt.wildcharm = vim.fn.char2nr("")

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

noremap("n", "s", "<nop>", "Disable [S]ubstitute to allow search chaining")
noremap("n", "<esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

noremap("t", "<C-e>", "<C-\\><C-n>", "[E]xit terminal mode")

noremap("n", "<C-s>", "<cmd>split<CR>", "[S]plit window horizontally")
noremap("n", "<C-v>", "<cmd>vsplit<CR>", "Split window [V]ertically")
noremap("n", "<C-t>", "<cmd>tabedit %<CR>", "New [T]ab")
noremap("n", "<C-z>", "<cmd>only<CR>", "Close all windows except current one")
noremap("n", "<C-x>", "<cmd>quit<CR>", "Close window")
noremap("n", "<C-w>", "<cmd>tabclose<CR>", "Close tab")
noremap("n", "<M-=>", "<C-w>=", "Resize all windows equally")

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

noremap("n", "<leader>L", vim.diagnostic.reset, "Clear diagnostics")

noremap("n", "<leader>f", "za", "Toggle [F]old under cursor")

noremap("n", "<leader>r", vim.lsp.buf.rename, "[R]ename")
noremap("n", "<leader>a", vim.lsp.buf.code_action, "Code [A]ction")
noremap("n", "<leader>h", vim.lsp.buf.hover, "Show [H]elp")

noremap("i", "<C-s>", vim.lsp.buf.signature_help, "Show [S]ignature help")

noremap("n", "<leader>H", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Toggle inlay [H]ints")
