-- init.lua
--
-- Neovim configuration file.
--
-- Requires `git`, `make`, `ripgrep`, and optionally a Nerd Font.

-- Set <space> as the leader key.
--  See `:help mapleader`
--  NOTE: Must happen before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal.
--  NOTE: Must happen before options and plugins are loaded.
vim.g.nerd_font_enabled = true

-- Set color scheme.
vim.cmd.colorscheme("darcula256")

-- Load basic configs.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run:
--    :Lazy
--
--  Press `?` in this menu for help. Use `q` to close the window.
require("config.lazy")
