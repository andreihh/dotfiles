-- [[ Setting options ]]
--  See `:help vim.opt`
--  For more options, see `:help option-list`

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
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.diagnostic.config({
  signs = {
    -- Increase diagnostic gutter signs priority over VCS and sort by severity.
    priority = 11,
    severity_sort = true,
    -- Set diagnostic gutter icons if you have a Nerd Font.
    text = vim.g.nerd_font_enabled and {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌶",
    } or {},
  },
})

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable mouse mode, can be useful for resizing splits.
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- When changing indent level, round to nearest multiple of `shiftwidth`.
vim.opt.shiftround = true

-- Keep current indent for wrapped lines.
vim.opt.breakindent = true

-- Keep current indent when starting a new line.
vim.opt.autoindent = true

-- Do smart autoindenting when starting a new line.
vim.opt.smartindent = true

-- Save undo history.
vim.opt.undofile = true

-- Case-insensitive searching unless \C or one or more capital letters in the
-- search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live, as you type.
vim.opt.inccommand = "split"

-- Decrease update time.
vim.opt.updatetime = 250

-- Minimal number of screen lines and columns to keep around the cursor.
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2

-- Write all buffers before navigating outside of Neovim.
vim.g.tmux_navigator_save_on_switch = 1

-- If Neovim is the zoomed pane, wrap around Neovim instead of unzooming.
vim.g.tmux_navigator_disable_when_zoomed = 1

-- Windows should be resized in increments of 5.
vim.g.tmux_resizer_resize_count = 5
vim.g.tmux_resizer_vertical_resize_count = 5
