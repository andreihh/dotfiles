-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`

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

-- General:
--  - S = [s]ave buffer
--  - Q = [q]uit all
--  - q = [q]uit special window / tab or record macro
--  - <esc> = clear search highlights
--  - u = [u]ndo
--  - <C-r> = [r]edo
--  - <C-c> = [c]opy to system clipboard using OSC52
--  - <C-b> = send to [b]ackground
--  - s + s/u/r = [s]ort [s]imple / [u]nique / [r]everse
--  - v + <C-V> = [v]isual block mode
--  - K = show [k]eyword help
--  - <leader>t + h/t/d/s = [t]oggle option
--  - <leader>P = [p]lugin manager
--  - <leader>S = [s]ession manager
--  - <M-s> = [s]ave session
--  - <M-/> = show keymap help
map("n", "S", "<cmd>write<CR>", "[S]ave buffer")
map("n", "Q", "<cmd>quitall<CR>", "[Q]uit all")
map("n", "q", function()
  if vim.tbl_contains({ "help", "quickfix" }, vim.bo.buftype) then
    vim.cmd("quit")
  elseif pcall(vim.api.nvim_tabpage_get_var, 0, "is_diff_tab") then
    vim.cmd("tabclose")
  else
    vim.api.nvim_feedkeys("q", "n", false)
  end
end, "[Q]uit special window / tab or record macro")
map("n", "<esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")
map({ "n", "x" }, "<C-c>", '"+y', "[C]opy to system clipboard using OSC52")
map("n", "<C-c><C-c>", '"+y_', "[C]opy line to system clipboard using OSC52")
map("n", "<C-b>", "<cmd>stop<CR>", "Send to [B]ackground")
map("x", "ss", ":sort<CR>", "[S]ort [S]imple")
map("x", "su", ":sort u<CR>", "[S]ort [U]nique")
map("x", "sr", ":sort!<CR>", "[S]ort [R]everse")
map("n", "<leader>P", "<cmd>Lazy<CR>", "[P]lugin manager")

-- Navigation:
--  - j/k = move down / up by display line
--  - gj / gk = [g]o to previous / next location
--  - gf = [g]o to [f]ile under cursor / selected [f]ile
--  - gx = [g]o to URI with e[x]ternal system handler
--  - g + {1-9} = [g]o to tab
--  - <C-u/d> = jump half page [u]p / [d]own
--  - { / } = jump to previous / next blank line
--  - f/F/t/T/;/, = enhanced find motions
--  - <C-f> = multi-window [f]ind
--  - [q / ]q / [Q / ]Q = jump to previous / next / first / last [q]uickfix
--  - [l / ]l / [L / ]L = jump to previous / next / first / last [l]ocation
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "gj", "<C-o>", "[G]oto previous location")
map("n", "gk", "<C-i>", "[G]oto next location")
for i = 1, 9 do
  map("n", "g" .. i, i .. "gt", "[G]oto tab " .. i)
end

-- Marks:
--  - m + {a-zA-Z} = set [m]ark
--  - dm + {a-zA-Z} = [d]elete [m]ark
--  - dm + !/* = [d]elete buffer / all [m]arks
--  - ' + {a-zA-Z} = go to mark line
--  - ` + {a-zA-Z} = go to mark
for m in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"):gmatch(".") do
  map("n", "dm" .. m, "<cmd>delmarks " .. m .. "<CR>", "[D]elete [M]ark " .. m)
end
map("n", "dm!", "<cmd>delmarks!<CR>", "[D]elete [!] buffer [M]arks")
map("n", "dm*", "<cmd>delmarks a-zA-Z<CR>", "[D]elete [*] all [M]arks")

-- Window:
--  - <C-s/v/t/z/x> = perform window action
--  - <M-x> = close tab
--  - <C-h/j/k/l> = navigate panes across Vim and `tmux`
--  - <M-h/j/k/l/=> = resize panes across Vim and `tmux`
map("n", "<C-s>", "<cmd>split<CR>", "[S]plit window horizontally")
map("n", "<C-v>", "<cmd>vsplit<CR>", "Split window [V]ertically")
map("n", "<C-t>", "<cmd>tabedit %<CR>", "Open window in new [T]ab")
map("n", "<C-x>", "<cmd>quit<CR>", "Close window")
map("n", "<M-x>", "<cmd>tabclose<CR>", "Close tab")
map("n", "<M-=>", "<C-w>=", "Resize all windows equally")

-- Terminal:
--  - X = open terminal
--  - <C-e> = [e]xit terminal mode
map("n", "X", "<cmd>terminal<CR>", "Open terminal")
map("t", "<C-e>", "<C-\\><C-n>", "[E]xit terminal mode")

-- Search:
--  - s + ?/r/h/m/'/b/+/f/F/g/G/c/j/l/q/d/D/s/S/"/:// = [s]earch
--  - <C-j/k/f> = select next / previous / find item
--  - <C-u/d> = scroll preview [u]p / [d]own
--  - <C-l/p> = toggle [l]ist / [p]review line wrap
--  - <tab> = accept selected / toggled items
--  - <S-tab> = toggle selected item
--  - <C-o/s/v/t> = open selected item in window
--  - <M-h/i/f> = toggle [h]idden / [i]gnored / [f]ollow flags
--  - <C-x> = close buffer / delete mark / reset changes
--  - <C-c> / <esc> = [c]ancel
--  - <M-/> = show keymap help
map("n", "s", "<nop>", "Disable [S]ubstitute to allow search chaining")

-- Explorer:
--  - g- = [g]o to [p]arent directory
--  - gf = [g]o to [f]ile / [f]older
--  - gx = [g]o to URI with e[x]ternal system handler
--  - gh = [g]o to toggle [h]idden files
--  - gs = [g]o to change [s]orting options
--  - gr = [g]o to [r]efresh current directory
--  - q = [q]uit
--  - g? = show help

-- Input:
--  - <tab> = accept input
--  - <C-n/p> = select [n]ext / [p]revious item from input history
--  - <esc> = exit from insert / visual / normal mode
--  - <C-c> = [c]ancel from insert mode
--  - q = [q]uit from normal mode

-- VCS:
--  - [c / ]c / [C / ]C = jump to previous / next / first / last [c]hanged hunk
--  - <leader>vu = [v]iew [u]nsaved buffer changes
--  - <leader>v + d/h/H = [V]CS [d]iff / (file) [h]istory
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
--  - <leader>V = [V]CS manager
--    - q = [q]uit
--    - ? = show help
map("n", "<leader>vu", function()
  vim.cmd([[
    let filetype=&ft
    tab split
    let t:is_diff_tab=1
    leftabove vnew | read ++edit # | normal! 1Gdd
    execute "setlocal bt=nofile bh=wipe nobl noswf ro noma ft=" . filetype
    windo :diffthis
  ]])
end, "[V]iew [U]nsaved buffer changes")

-- Completion:
--  - <C-j/k> = trigger completion / select next / previus item
--  - <C-h/l> = jump to previous / next snippet placeholder
--  - <C-u/d> = scroll documentation [u]p / [d]own
--  - <C-n/p> = select [n]ext / [p]revious item from command history
--  - <tab> = accept selected item
--  - <C-c> = [c]ancel

-- Treesitter:
--  - a/i + b/m = [a]round / [i]nside [b]lock / [m]ethod
--  - [m / ]m / [M / ]M = jump to previous / next start / end of [m]ethod
--  - <leader> + cc/c/f/- = perform code action
map("n", "<leader>cc", "gcc", { desc = "Toggle line [C]omment", remap = true })
map({ "n", "x" }, "<leader>c", "gc", {
  desc = "Toggle [C]omment",
  remap = true,
  nowait = false,
})
map("n", "<leader>f", "za", "Toggle [F]old under cursor")

-- LSP:
--  - g + d/D/i/r = perform code navigation
--  - [r / ]r = jump to previous / next [r]eference
--  - [d / ]d / [w / ]w / [e / ]e = jump to previous / next diagnostic
--  - H / <C-s> / L = show [h]elp / [s]ignature / [l]int
--    - H / <C-s> / L = focus float
--    - q = [q]uit float if focused
--  - <leader> + =/r/a/A/q = perform LSP action
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
map("n", "L", vim.diagnostic.open_float, "Show [L]int diagnostic")
map("n", "<leader>r", vim.lsp.buf.rename, "[R]ename")
map("n", "<leader>A", vim.lsp.codelens.run, "Code lens [A]ction")
map(
  "n",
  "<leader>q",
  "<cmd>cclose<CR><cmd>lclose<CR>",
  "[Q]uit quickfix / location list"
)

-- AI:
-- - <leader><leader> + a/n/e/r/f/s/t/D/H/S/R/c/b/?/h = perform AI action
-- - <tab> = switch window focus
-- - <C-n/p> = select [n]ext / [p]revious prompt
-- - <C-s/c> = [s]bumit / [c]ancel from insert mode
-- - <CR> = submit from normal mode
-- - q = [q]uit from normal mode
