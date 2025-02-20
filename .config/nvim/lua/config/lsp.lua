-- [[ LSP configs ]]
--  See `help mason-lspconfig-dynamic-server-setup`

--- Global LSP configs: servers, formatters, linters, tools to install, etc.
---
--- All fields must be defined and not `nil`. Some features (Treesitter, LSP,
--- folding, etc.) are disabled locally for big files.
---
---@class config.LspConfig
---@field treesitter_enabled boolean Enable / disable Treesitter globally
---@field servers table<string, config.LspServerConfig> LSP server configs
---@field format config.FormatConfig Formatting config
---@field lint config.LintConfig Linting config
---@field ensure_installed string[] List of tools to install automatically

--- LSP server configuration: command, filetypes, capabilities, etc.
---
--- Server-specific options can be forwarded through the `settings`. For
--- example, for `lua_ls` options, see:
---   https://luals.github.io/wiki/settings/
---
--- See `:help lspconfig`.
---
---@alias config.LspServerConfig vim.lsp.Config

--- Formatting configuration.
---
--- See `:help conform`.
---
---@alias config.FormatConfig conform.setupOpts

--- Linting configuration.
---
--- See `:help lint`.
---
---@class config.LintConfig
---@field linters? table<string, config.Linter> Linter configs
---@field linters_by_ft? table<string, string[]> Linters by filetype

--- Linter configuration.
---
--- See `:help lint.Linter`.
---
---@alias config.Linter lint.Linter

--- Global LSP configs.
---
--- Must be defined and not `nil`. By default, it has:
--- - Treesitter enabled
--- - Big file size threshold of 1 MiB
--- - LSPs, formatters and linters for Lua, Vimscript and Bash.
---
--- NOTE: `ensure_installed` is a list and needs to be extended with
--- `vim.list_extend` or fully overwritten with `vim.tbl_deep_extend`.
---
---@type config.LspConfig
vim.g.lsp = {
  treesitter_enabled = true,
  servers = {
    lua_ls = {
      settings = {
        Lua = {
          telemetry = { enable = false },
          completion = { callSnippet = "Replace" },
          -- Ignore LuaLS's noisy `missing-fields` warnings.
          diagnostics = { disable = { "missing-fields" } },
        },
      },
    },
    vimls = {},
    bashls = {},
  },
  format = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
    },
  },
  lint = {},
  ensure_installed = {
    "lua_ls",
    "vimls",
    "bashls",
    "stylua",
    "shfmt",
    "shellcheck", -- `bashls` integrates with `shellcheck` if installed
  },
}
