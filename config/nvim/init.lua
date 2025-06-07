-- init.lua: configures Neovim.
--
-- Requirements:
--  - Terminal capabilities: truecolors, Nerd Font, OSC52
--  - Tools: `git`, `curl`, `fzf`, `fd`, `ripgrep`

-- Load basic configs.
--  NOTE: must happen before plugins, color schemes, or overrides are loaded.
require("config.options")
require("config.autocmds")
require("config.keymaps")

-- Load optional user overrides.
pcall(require, "config.overrides")

-- Configure and install plugins.
require("config.lazy")
