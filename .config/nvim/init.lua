-- init.lua: configures Neovim.
--
-- Requires `git`, `curl`, `fzf`, `fd`, `ripgrep`, and a Nerd Font.

-- Load basic configs.
--  NOTE: must happen before plugins, color schemes, or overrides are loaded.
require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lsp")

-- Load optional user overrides.
pcall(require, "config.overrides")

-- Configure and install plugins.
require("config.lazy")
