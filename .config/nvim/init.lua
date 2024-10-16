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
