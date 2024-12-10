-- init.lua: configures Neovim.
--
-- Requires `git`, `curl`, `fzf`, `fd`, `ripgrep`, and optionally a Nerd Font.

-- Set <space> as the leader key.
--  See `:help mapleader`
--  NOTE: Must happen before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Returns if a Nerd Font is installed and selected in the terminal.
---
--- @return boolean
function _G.NerdFontEnabled()
  return vim.fn.empty(vim.env.NERD_FONT_ENABLED) == 0
end

--- Returns if true colors are supported by the terminal.
---
--- @return boolean
function _G.TrueColorsEnabled()
  local color_support = vim.env.COLORTERM
  return color_support == "truecolor" or color_support == "24bit"
end

-- Load basic configs.
--  NOTE: must happen before plugins, color schemes, or overrides are loaded.
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")

-- Load optional user overrides.
pcall(require, "config.overrides")

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run:
--    :Lazy
--
--  Press `?` in this menu for help. Use `q` to close the window.
require("config.lazy")
