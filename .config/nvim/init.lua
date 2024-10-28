-- init.lua: configures Neovim.
--
-- Requires `git`, `make`, `ripgrep`, and optionally a Nerd Font.

-- Set <space> as the leader key.
--  See `:help mapleader`
--  NOTE: Must happen before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable icons if you have a Nerd Font installed and selected in the terminal.
--  NOTE: Must happen before options and plugins are loaded.
vim.g.nerd_font_enabled = vim.fn.empty(vim.env.NERD_FONT_ENABLED) == 0

-- Load basic configs.
--  NOTE: must happen before plugins, colorschemes, or overrides are loaded.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load optional user overrides.
pcall(require, "config.overrides")

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run:
--    :Lazy
--
--  Press `?` in this menu for help. Use `q` to close the window.
require("config.lazy")
