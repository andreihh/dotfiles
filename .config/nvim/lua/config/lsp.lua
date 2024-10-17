-- [[ LSP configs ]]
--  See `help mason-lspconfig-dynamic-server-setup`

local M = {
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
  servers = {
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          -- Ignore Lua_LS's noisy `missing-fields` warnings.
          diagnostics = { disable = { "missing-fields" } },
        },
      },
    },
    bashls = {},
    pyright = {},
    clangd = {},
    jdtls = {},
    kotlin_language_server = {},
  },
  -- Enable the following formatters.
  --  Add/remove desired formatters here. They will be automatically installed.
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt", "shellcheck" },
    python = { "yapf" },
    cpp = { "clang-format" },
    java = { "google-java-format" },
    kotlin = { "ktfmt" },
    markdown = { "prettier" },
  },
  -- Configure formatters that don't support a config file to use Google style.
  formatter_opts = {
    shfmt = { prepend_args = { "-i", "2", "-sr", "-ci", "-bn", "-kp" } },
    ktfmt = { prepend_args = { "--google-style" } },
  },
  -- Set tags to highlight sources in the completion menu.
  cmp_source_tags = {
    nvim_lsp = "[LSP]",
    vsnip = "[Snip]",
    buffer = "[Buffer]",
    path = "[Path]",
  },
}

-- You can add other tools that you want to install here.
M.ensure_installed = vim.tbl_keys(M.servers or {})
vim.list_extend(
  M.ensure_installed,
  vim.iter(vim.tbl_values(M.formatters_by_ft or {})):flatten():totable()
)

return M
