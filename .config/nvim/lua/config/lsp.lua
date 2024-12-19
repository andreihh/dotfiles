-- [[ LSP configs ]]
--  See `help mason-lspconfig-dynamic-server-setup`

--- Global LSP configs: servers, formatters, linters, tools to install, etc.
---
--- All fields must be defined and not `nil`. Some features (Treesitter, LSP,
--- folding, etc.) are disabled locally for big files.
---
---@class config.LspConfig
---@field bigfile_size number Big file size threshold in bytes
---@field treesitter_enabled boolean Enable / disable Treesitter globally
---@field servers table<string, config.LspServerConfig> LSP server configs
---@field formatters_by_ft table<string, string[]> Formatters by filetype
---@field formatters table<string, config.FormatterConfig> Formatter configs
---@field linters_by_ft table<string, string[]> Linters by filetype
---@field ensure_installed string[] List of tools to install automatically

--- LSP server configuration: command, filetypes, capabilities, etc.
---
--- Server-specific options can be forwarded through the `settings`. For
--- example, for `lua_ls` options, see:
---   https://luals.github.io/wiki/settings/
---
--- See `:help lspconfig-all` for a list of all pre-configured LSPs.
---
---@class config.LspServerConfig
---@field cmd? string[] Command used to start the server
---@field filetypes? string[] List of associated filetypes for the server
---@field capabilities? lsp.ClientCapabilities LSP features to disable / enhance
---@field root_dir? string Root directory in which to start the server
---@field settings? table Settings passed when initializing the server

--- Formatter configuration: command, args, etc.
---
--- See `:help conform-formatters` for a list of all pre-configured formatters.
---
---@class config.FormatterConfig
---@field command? string Command to run the formatter
---@field args? string[] Command args provided to the formatter
---@field prepend_args? string[] Command args to prepend to default args
---@field append_args? string[] Command args to append to default args
---@field range_args? fun(ctx: config.RangeContext): string[] Range format args
---@field env? table<string, string> Environment args provided to the formatter

--- Buffer range context.
---
---@class config.RangeContext
---@field range config.Range

--- Buffer range with `{row, col}` tuples using `(1, 0)` indexing.
---
---@class config.Range
---@field start integer[]
---@field end integer[]

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
  bigfile_size = 1 * 1024 * 1024,
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
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
  },
  formatters = {},
  linters_by_ft = {},
  ensure_installed = {
    "lua_ls",
    "vimls",
    "bashls",
    "stylua",
    "shfmt",
    "shellcheck", -- `bashls` integrates with `shellcheck` if installed
  },
}
