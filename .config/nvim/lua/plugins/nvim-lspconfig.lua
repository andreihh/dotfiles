return {
  -- Default LSP configs.
  --  See `:help vim.lsp.config()`
  { "neovim/nvim-lspconfig", lazy = true },
  -- Package manager for development tools (LSPs, formatters, linters, etc.).
  --  To check the current status of installed tools and/or manually install
  --  other tools run:
  --    :Mason
  --
  --  You can press `g?` for help in this menu.
  { "williamboman/mason.nvim", config = true },
  { -- Automatically install required tools to `stdpath()`.
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = vim.list_extend({
        "lua-language-server",
        "vim-language-server",
        "bash-language-server",
        "ansible-language-server",
        "shellcheck", -- integrates with `bash-language-server`
        "ansible-lint", -- integrates with `ansible-language-server`
        "stylua",
        "shfmt",
        "prettier",
      }, vim.g.ensure_installed or {}),
    },
  },
}
