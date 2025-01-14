-- [[ Setting options ]]
--  See `:help vim.opt`
--  For more options, see `:help option-list`

-- Enable true colors if supported by the terminal.
vim.opt.termguicolors = vim.env.COLORTERM == "truecolor"
  or vim.env.COLORTERM == "24bit"

-- Make Esc more responsive.
vim.o.ttimeoutlen = 5

-- Don't show the mode, since it's already in the status line.
vim.opt.showmode = false

-- Don't automatically wrap lines.
vim.opt.wrap = false

-- Make line numbers default.
vim.opt.number = true

-- Enable relative line numbers to help with jumping.
vim.opt.relativenumber = true

-- Highlight column after `textwidth`.
vim.opt.colorcolumn = "+1"

-- Keep sign column on by default.
vim.opt.signcolumn = "yes"

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
    -- Prioritize diagnostic gutter signs by severity.
    severity_sort = true,
    -- Icons require a Nerd Font.
    text = NerdFontEnabled()
        and { -- Match Lualine diagnostic icons
          [vim.diagnostic.severity.ERROR] = "󰅚", -- `nf-md-close_circle_outline`
          [vim.diagnostic.severity.WARN] = "󰀪", -- `nf-md-alert_outline`
          [vim.diagnostic.severity.INFO] = "󰋽", -- `nf-md-information_outline`
          [vim.diagnostic.severity.HINT] = "󰌶", -- `nf-md-lightbulb_outline`
        }
      or {},
  },
  -- Include diagnostic source in float.
  float = { source = true },
})

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines and columns to keep around the cursor.
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 2

-- Enable mouse mode, can be useful for resizing splits.
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UIEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- When changing indent level, round to nearest multiple of `shiftwidth`.
vim.opt.shiftround = true

-- Keep current indent for wrapped lines.
vim.opt.breakindent = true

-- Do smart autoindenting when starting a new line.
vim.opt.smartindent = true

-- Don't automatically close folds when opening a file.
vim.opt.foldlevelstart = 99

-- Use indent folds by default.
vim.opt.foldmethod = "indent"

-- Case-insensitive searching unless `\C` or one or more capital letters in the
-- search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live, as you type.
vim.opt.inccommand = "split"

-- Decrease update time.
vim.opt.updatetime = 250

-- Save undo history.
vim.opt.undofile = true

-- Don't emit completion messages.
vim.opt.shortmess:append("c")

-- What to store in a session. Don't save:
-- - unloaded and hidden buffers
-- - global options and variables
-- - session directory
vim.o.sessionoptions =
  "blank,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Use POSIX shell syntax highlighting.
vim.g.is_posix = 1
