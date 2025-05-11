-- Disable plugins for view-only mode.
return vim.g.viewonly
    and { -- Keep sorted
      { "WhoIsSethDaniel/mason-tool-installer.nvim", cond = false },
      { "folke/flash.nvim", cond = false },
      { "folke/lazydev.nvim", cond = false },
      { "folke/ts-comments.nvim", cond = false },
      { "kosayoda/nvim-lightbulb", cond = false },
      { "kylechui/nvim-surround", cond = false },
      { "mfussenegger/nvim-lint", cond = false },
      { "neovim/nvim-lspconfig", cond = false },
      { "rafamadriz/friendly-snippets", cond = false },
      { "rmagatti/auto-session", cond = false },
      { "saghen/blink.cmp", cond = false },
      { "sindrets/diffview.nvim", cond = false },
      { "stevearc/conform.nvim", cond = false },
      { "williamboman/mason.nvim", cond = false },
    }
  or {}
