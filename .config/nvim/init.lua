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

-- Load basic configs.
--  NOTE: must happen before plugins, color schemes, or overrides are loaded.
require("config.settings")
require("config.commands")
require("config.autocmds")
require("config.mappings")
require("config.lsp")

-- Load optional user overrides.
pcall(require, "config.overrides")

-- Configure and install plugins.
require("config.lazy")
