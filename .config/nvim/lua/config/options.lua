-- [[ Setting options ]]
--  See `:help vim.opt`
--  For more options, see `:help option-list`

vim.o.ttimeoutlen = 5 -- Make Esc more responsive
vim.opt.updatetime = 250 -- Decrease update time

-- Enable true colors. Disable if not supported by the terminal.
vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim using OSC52.
--  Schedule the setting after `UIEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
  }
end)

vim.opt.showmode = false -- Don't show the mode, it's already in the status line
vim.opt.wrap = false -- Don't automatically wrap lines
vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers
vim.opt.colorcolumn = "+1" -- Highlight column after `textwidth`
vim.opt.signcolumn = "yes" -- Enable sign column

-- Sets how to display certain whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  precedes = "◀",
  extends = "▶",
}

vim.diagnostic.config({
  signs = {
    severity_sort = true, -- Prioritize diagnostic gutter signs by severity
    text = { -- Match Lualine diagnostic icons
      [vim.diagnostic.severity.ERROR] = "󰅚", -- `nf-md-close_circle_outline`
      [vim.diagnostic.severity.WARN] = "󰀪", -- `nf-md-alert_outline`
      [vim.diagnostic.severity.INFO] = "󰋽", -- `nf-md-information_outline`
      [vim.diagnostic.severity.HINT] = "󰌶", -- `nf-md-lightbulb_outline`
    },
  },
  float = { source = true }, -- Show diagnostic source in float
})

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines and columns to keep around the cursor.
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 2

vim.opt.shiftround = true -- Round indents to nearest multiple of `shiftwidth`
vim.opt.breakindent = true -- Keep current indent for wrapped lines
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line

vim.opt.foldlevelstart = 99 -- Don't auto-close folds when opening a file
vim.opt.foldmethod = "indent" -- Use indent folds by default

-- Case-insensitive searching unless `\C` or one or more capital letters in the
-- search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split" -- Preview substitutions live, as you type

vim.opt.undofile = true -- Save undo history

-- What to store in a session. Don't save:
-- - Unloaded and hidden buffers
-- - Global options and variables
-- - Session directory
vim.o.sessionoptions =
  "blank,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.is_posix = 1 -- Use POSIX shell syntax highlighting
