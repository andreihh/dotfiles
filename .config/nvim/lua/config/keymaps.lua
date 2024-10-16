-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- General:
--  - <esc> = clear search highlights
--  - q = [q]uit visual mode
--  - <C-e> = [e]xit terminal mode
--  - g + 1..9 = go to tab 1..9
--  - gj / gk = go to previous / next location
--  - go = [o]pen URI
--  - [c / ]c = go to previous / next [c]hanged hunk
-- Window:
--  - <C-o/t/s/v/z/x/w> = perform window action
--  - <C-h/j/k/l> = navigate panes across Vim and `tmux`
--  - <M-h/j/k/l/=> = resize panes across Vim and `tmux`
-- Telescope:
--  - <C-n/p> = select [n]ext / [p]revious option
--  - <C-o> = [o]pen selected option
--  - <C-s/v> = open option in horizontal [s]plit / [v]ertical split
--  - <C-e> = [e]xit
--  - <C-h> = trigger [h]op
--  - s + s/h/k/v/f/r/c/g/d/q/w// = [s]earch with picker
-- Completion:
--  - <C-n/p> = select [n]ext / [p]revious option
--  - <C-u/d> = scroll documentation window [u]p / [d]own
--  - <C-l/h> = jump in snippet
--  - <tab> = accept selected option
--  - <C-e> = [e]xit
--  - <C-space> = trigger completion
-- LSP:
--  - g + d/D/i/r = perform code action
--  - [d / ]d / [w / ]w / [e / ]e = go to previous / next diagnostic by severity
--  - <leader>h = show [h]elp
--    - <leader>h = focus [h]elp
--    - q = [q]uit help if focused
--  - <C-h> = show [s]ignature help
--  - <leader> + c/r/a/=/H = perform code action

local function noremap(mode, lhs, rhs, description)
  vim.keymap.set(mode, lhs, rhs, { desc = description, noremap = true })
end

local function nnoremap(lhs, rhs, description)
  noremap("n", lhs, rhs, description)
end

nnoremap("s", "<nop>", "Disable [S]ubstitute command to allow search chaining")
nnoremap("<esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

noremap("v", "q", "<esc>", "[Q]uit visual mode")
noremap("t", "<C-e>", "<C-\\><C-n>", "[E]xit terminal mode")

nnoremap("<C-o>", ":edit %:p:h<C-z>", "[O]pen new file in current buffer")
nnoremap("<C-t>", ":tabedit %<CR>", "New [T]ab")
nnoremap("<C-s>", ":split<CR>", "[S]plit window horizontally")
nnoremap("<C-v>", ":vsplit<CR>", "Split window [V]ertically")
nnoremap("<C-z>", ":only<CR>", "Close all windows except current one")
nnoremap("<C-x>", ":quit<CR>", "Close window")
nnoremap("<C-w>", ":tabclose<CR>", "Close tab")
nnoremap("<M-=>", "<C-w>=", "Resize all windows equally")

for i = 1, 9 do
  nnoremap("g" .. i, i .. "gt", "[G]o to tab number [" .. i .. "]")
end

nnoremap("gj", "<C-o>", "[G]o to previous location")
nnoremap("gk", "<C-i>", "[G]o to next location")

-- Open URI under cursor or selected URI with the system handler.
vim.cmd("map go gx")

-- WARN: This is not Goto Definition, this is Goto Declaration.
--  For example, in C this would take you to the header.
noremap("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

nnoremap("[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, "Jump to previous [E]rror")

nnoremap("]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, "Jump to next [E]rror")

nnoremap("[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, "Jump to previous [W]arning")

nnoremap("]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, "Jump to next [W]arning")

noremap(
  { "n", "v" },
  "<leader>c",
  ":Commentary<CR>",
  "[C]omment line or selected range"
)

nnoremap("<leader>r", vim.lsp.buf.rename, "[R]ename")
nnoremap("<leader>a", vim.lsp.buf.code_action, "Code [A]ction")
nnoremap("<leader>h", vim.lsp.buf.hover, "Show [H]elp")

noremap("i", "<C-s>", vim.lsp.buf.signature_help, "Show [S]ignature help")

nnoremap("<leader>H", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Toggle inlay [H]ints")
