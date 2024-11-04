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
    sh = { "shfmt" },
    python = { "yapf" },
    cpp = { "clang-format" },
    java = { "google-java-format" },
    kotlin = { "ktfmt" },
    markdown = { "prettier" },
  },
  -- Configure formatters that don't support a config file to use Google style.
  formatter_opts = {
    ktfmt = { prepend_args = { "--google-style" } },
  },
  -- Enable the following linters.
  --  Add/remove desired linters here. They will be automatically installed.
  linters_by_ft = {
    -- `bashls` integrates with `shellcheck` if installed
    python = { "pylint" },
    -- `clangd` embeds `clang-tidy`
    java = { "checkstyle" },
  },
}

-- Add configured servers.
M.ensure_installed = vim.tbl_keys(M.servers or {})

-- Add configured formatters.
vim.list_extend(
  M.ensure_installed,
  vim.iter(vim.tbl_values(M.formatters_by_ft or {})):flatten():totable()
)

-- Add configured linters.
vim.list_extend(
  M.ensure_installed,
  vim.iter(vim.tbl_values(M.linters_by_ft or {})):flatten():totable()
)

-- Add other tools you want to install here.
vim.list_extend(M.ensure_installed, {
  "shellcheck", -- `bashls` integrates with `shellcheck` if installed
})

return M
