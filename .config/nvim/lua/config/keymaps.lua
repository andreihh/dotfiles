-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- General:
--  - M = [m]anage plugins
--  - S = [s]ave buffer
--  - Q = [q]uit
--  - K = show [k]eyword help
--  - <esc> = clear search highlights
--  - u = [u]ndo
--  - <C-r> = [r]edo
--  - <C-c> = [c]opy to system clipboard using OSC52
--  - s + a/d/A/S = [s]ort [a]scending / [d]escending (unique)
--  - gj / gk = [g]o to previous / next location
--  - gf = [g]o to [f]ile under cursor / selected [f]ile
--  - gx = [g]o to URI with e[x]ternal system handler
--  - g + {1-9} = [g]o to tab
--  - <C-u/d> = jump half page [u]p / [d]own
--  - { / } = jump to previous / next blank line
--  - f/F/t/T/;/, = enhanced [F]lash motions
--  - <C-f> = multi-window Flash [f]ind
--  - [q / ]q / [Q / ]Q = jump to previous / next / first / last [q]uickfix
--  - [l / ]l / [L / ]L = jump to previous / next / first / last [l]ocation
--  - <M-V> = [v]isual block mode
--  - <C-\> = show keymap help
-- Marks:
--  - m + {a-zA-Z} = set [m]ark
--  - dm + {a-zA-Z} = [d]elete [m]ark
--  - dm + !/* = [d]elete buffer / all [m]arks
--  - ' + {a-zA-Z} = go to mark line
--  - ` + {a-zA-Z} = go to mark
-- Window:
--  - <C-s/v/t/z/x/w> = perform window action
--  - <C-h/j/k/l> = navigate panes across Vim and `tmux`
--  - <M-h/j/k/l/=> = resize panes across Vim and `tmux`
-- Terminal:
--  - X = open terminal
--  - <C-e> = [e]xit terminal mode
-- Session:
--  - dS = [d]elete [s]ession
--  - <M-S> = [s]ave session
-- Search:
--  - s + <space>/p/h/m/k/f/r/b/c/g/s/d/w/./+/:/'// = [s]earch with picker
--  - <C-j/k> = select next / previous item
--  - <C-f> = Flash-like [f]ind
--  - <C-u/d> = scroll preview [u]p / [d]own
--  - <C-l/p> = toggle [l]ine / [p]review wrapping for long lines
--  - <tab> = accept selected / toggled items
--  - <S-tab> = toggle selected item
--  - <C-o/s/v/t> = open selected item in window
--  - <M-h/i/f> = toggle [h]idden / [i]gnored / [f]ollow flags
--  - <C-x> = close buffer / delete mark / reset changes
--  - <esc> = exit
--  - <C-\> = show keymap help
-- Explorer:
--  - <C-o> = [o]pen / refresh file explorer
--  - gf = [g]o to [f]ile / [f]older
--  - gp = [g]o to [p]arent directory
--  - gx = [g]o to URI with e[x]ternal system handler
--  - gh = toggle [g]o to [h]idden files
--  - <C-e> = [e]xit
--  - g? = show help
-- Input:
--  - <tab> = accept input
--  - <C-j/k> = select previous / next item from input history
--  - <esc> = exit from insert / visual / normal mode
--  - <C-e> = [e]xit
-- VCS:
--  - [c / ]c / [C / ]C = jump to previous / next / first / last [c]hanged hunk
--  - dvu = [d]iff [v]iew [u]nsaved buffer changes
--  - dv + o/O/h/H/b = [d]iff [v]iew [o]pen / (file) [h]istory / [b]lame
--    - <tab> / <S-tab> = diff next / previous file
--    - gf = [g]o to edit [f]ile
--    - j/k = select next / previous entry
--    - l = open selected entry
--    - h = close fold
--    - y = [y]ank commit hash
--    - L = open commit [l]og
--    - R = [r]efresh entries
--    - dp = [d]iff [p]ut
--    - do = [d]iff [o]btain
--    - 1/2/3 + do = [d]iff [o]btain from BASE / OURS / THEIRS
--    - [x / ]x = jump to previous / next conflict
--    - dx / dX = [d]elete (all) conflict(s)
--    - <leader>c + b/B/o/O/t/T/a/A = [c]hoose (all) conflict(s) from:
--        [B]ASE / [O]URS / [T]HEIRS / [a]ll
--    - q = [q]uit diff tab
--    - g? = show help
--  - <leader>g = open Lazy[G]it
--    - q = [q]uit
--    - ? = show help
-- Completion:
--  - <C-space> = trigger completion
--  - <C-j/k> = select next / previus item
--  - <C-h/l> = jump to previous / next snippet placeholder
--  - <C-u/d> = scroll documentation [u]p / [d]own
--  - <tab> = accept selected item
--  - <C-e> = [e]xit
-- LSP:
--  - g + d/D/i/r = perform code navigation
--  - [r / ]r = jump to previous / next [r]eference
--  - [d / ]d / [w / ]w / [e / ]e = jump to previous / next diagnostic severity
--  - H / <C-s> / L = show [h]elp / [s]ignature / [l]int
--    - H / <C-s> / L = focus float
--    - q = [q]uit float if focused
--  - <leader> + =/--/-/f/c/r/a/A/l/L/H/T/D = perform code action
-- Treesitter:
--  - [f / ]f / [t / ]t = jump to previous / next start of [f]unction / [t]ype
--  - [F / ]F / [T / ]T = jump to previous / next end of [f]unction / [t]ype
--  - a/i + f/t/b = [a]round / [i]nside [f]unction / [t]ype / [b]lock

-- Set `<space>` as the leader key.
--  See `:help mapleader`
--  NOTE: Must happen before setting any keymaps or loading any plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Sets the given keymap with the provided description or options.
---
--- Core keymaps shouldn't be recursive or have conflicts (thus no wait time),
--- so default options are:
---  - `remap = false`
---  - `nowait = true`
---
---@param mode string|string[] The modes where the keymap applies
---@param lhs string The left-hand side of the keymap
---@param rhs string|function The right-hand side of they keymap
---@param desc_or_opts string|table The keymap description or options
local function map(mode, lhs, rhs, desc_or_opts)
  local opts = type(desc_or_opts) == "table" and desc_or_opts
    or { desc = desc_or_opts }
  opts = vim.tbl_extend("keep", opts, { remap = false, nowait = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "M", "<cmd>Lazy<CR>", "[M]anage plugins")
map("n", "S", "<cmd>write<CR>", "[S]ave buffer")
map("n", "Q", "<cmd>quitall<CR>", "[Q]uit")
map("n", "<esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")
map({ "n", "x" }, "<C-c>", '"+y', "[C]opy to system clipboard using OSC52")
map("n", "<C-c><C-c>", '"+y_', "[C]opy line to system clipboard using OSC52")
map("x", "sa", ":sort u<CR>", "[S]ort [A]scending unique")
map("x", "sd", ":sort! u<CR>", "[S]ort [D]escending unique")
map("x", "sA", ":sort<CR>", "[S]ort [A]scending")
map("x", "sD", ":sort!<CR>", "[S]ort [D]escending")
map("n", "s", "<nop>", "Disable [S]ubstitute to allow search chaining")

map("n", "gj", "<C-o>", "[G]oto previous location")
map("n", "gk", "<C-i>", "[G]oto next location")
for i = 1, 9 do
  map("n", "g" .. i, i .. "gt", "[G]oto tab " .. i)
end

map("n", "<M-V>", "<C-v>", "[V]isual block mode")

for m in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"):gmatch(".") do
  map("n", "dm" .. m, "<cmd>delmarks " .. m .. "<CR>", "[D]elete [M]ark " .. m)
end
map("n", "dm!", "<cmd>delmarks!<CR>", "[D]elete [!] buffer [M]arks")
map("n", "dm*", "<cmd>delmarks a-zA-Z<CR>", "[D]elete [*] all [M]arks")

map("n", "dvu", function()
  vim.cmd([[
    let filetype=&ft
    tab split
    let t:is_diff_tab=1
    leftabove vnew | read ++edit # | normal! 1Gdd
    execute "setlocal bt=nofile bh=wipe nobl noswf ro noma ft=" . filetype
    windo :diffthis
  ]])
end, "[D]iff [U]nsaved changes")

map("n", "q", "exists('t:is_diff_tab') ? ':tabclose<CR>' : 'q'", {
  desc = "[Q]uit diff tab",
  expr = true,
})

map("n", "<C-s>", "<cmd>split<CR>", "[S]plit window horizontally")
map("n", "<C-v>", "<cmd>vsplit<CR>", "Split window [V]ertically")
map("n", "<C-t>", "<cmd>tabedit %<CR>", "Open window in new [T]ab")
map("n", "<C-x>", "<cmd>quit<CR>", "Close window")
map("n", "<C-w>", "<cmd>tabclose<CR>", "Close tab")
map("n", "<M-=>", "<C-w>=", "Resize all windows equally")

map("n", "X", "<cmd>terminal<CR>", "Open terminal")
map("t", "<C-e>", "<C-\\><C-n>", "[E]xit terminal mode")

local WARN = vim.diagnostic.severity.WARN
local ERROR = vim.diagnostic.severity.ERROR
local diagnostic_jump_opts = {
  { count = -1, severity = WARN, lhs = "[w", desc = "previous [W]arn" },
  { count = 1, severity = WARN, lhs = "]w", desc = "next [W]arn" },
  { count = -1, severity = ERROR, lhs = "[e", desc = "previous [E]rror" },
  { count = 1, severity = ERROR, lhs = "]e", desc = "next [E]rror" },
}
for _, jump_opts in ipairs(diagnostic_jump_opts) do
  map("n", jump_opts.lhs, function()
    vim.diagnostic.jump(jump_opts)
  end, "Jump to the " .. jump_opts.desc .. " diagnostic")
end

map("n", "H", vim.lsp.buf.hover, "Show [H]elp")
map({ "i", "s" }, "<C-s>", vim.lsp.buf.signature_help, "Show [S]ignature help")
map("n", "L", vim.diagnostic.open_float, "Show [L]int diagnostic")

map("n", "<leader>--", "gcc", { desc = "Toggle line comment", remap = true })
map({ "n", "x" }, "<leader>-", "gc", {
  desc = "Toggle comment",
  remap = true,
  nowait = false,
})

map("n", "<leader>f", "za", "Toggle [F]old under cursor")
map("n", "<leader>r", vim.lsp.buf.rename, "[R]ename")
map("n", "<leader>A", vim.lsp.codelens.run, "Run code lens [A]ction")
