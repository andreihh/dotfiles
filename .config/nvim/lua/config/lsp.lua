-- [[ LSP configs ]]
--  See `help mason-lspconfig-dynamic-server-setup`

--- Global LSP options: servers, formatters, linters, tools to install, etc.
---  Must be defined and not `nil`. Fields may be overridden. Fields explicitly
---  unset / set to `nil` will default to empty values (empty table, `false`,
---  etc.), except for `bigfile_size`, which defaults to 1 MiB.
---  otherwise.
---@class LspOpts
---@field bigfile_size? number Big file size threshold in bytes. Default: 1 MiB
---@field treesitter_enabled? boolean Enable Treesitter
---@field servers? table<string, table> LSP server configurations
---@field formatters_by_ft? table<string, string[]> Formatters by filetype
---@field formatter_opts? table<string, table> Formatter options
---@field linters_by_ft? table<string, string[]> Linters by filetype
---@field ensure_installed? string[] List of tools to install
vim.g.lsp_opts = {
  -- The threshold size of a big file in bytes. If unset, defaults to 1 MiB.
  --  If a file exceeds this size, then Treesitter, LSP, folding, etc. will be
  --  disabled locally.
  bigfile_size = 1 * 1024 * 1024,

  -- Enable or disable Treesitter globally.
  --  See `:help nvim-treesitter`
  treesitter_enabled = true,

  -- Enable the following language servers.
  --  Add/remove desired LSPs here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables.
  --  Available keys are:
  --  - cmd (table): Override the default command used to start the server
  --  - filetypes (table): Override the default list of associated filetypes for
  --    the server
  --  - capabilities (table): Override fields in capabilities. Can be used to
  --    disable certain LSP features.
  --  - settings (table): Override the default settings passed when initializing
  --    the server.
  --
  --  For example, to see the options for `lua_ls`, you could go to:
  --    https://luals.github.io/wiki/settings/
  --
  --  See `:help lspconfig-all` for a list of all the pre-configured LSPs.
  servers = {
    lua_ls = {
      settings = {
        Lua = {
          telemetry = { enable = false },
          completion = { callSnippet = "Replace" },
          -- Ignore Lua_LS's noisy `missing-fields` warnings.
          diagnostics = { disable = { "missing-fields" } },
        },
      },
    },
    vimls = {},
    bashls = {},
  },

  -- Enable the following formatters.
  --  Add/remove desired formatters here. They will be automatically installed.
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
  },

  -- Configure formatters with custom options to achieve the desired style.
  formatter_opts = {},

  -- Enable the following linters.
  --  Add/remove desired linters here. They will be automatically installed.
  linters_by_ft = {}, -- `bashls` integrates with `shellcheck` if installed

  -- Add other tools you want to install here.
  --  NOTE: this is a list and needs to be extended with `vim.list_extend` or
  --  fully overwritten with `vim.tbl_deep_extend`.
  ensure_installed = {
    "lua_ls",
    "vimls",
    "bashls",
    "stylua",
    "shfmt",
    "shellcheck", -- `bashls` integrates with `shellcheck` if installed
  },
}
