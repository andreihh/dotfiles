-- Disable plugins for view-only mode (diff, read-only, non-modifiable).
return (vim.o.diff or vim.o.readonly or not vim.o.modifiable)
    and {
      { "rmagatti/auto-session", cond = false },
      { "stevearc/oil.nvim", cond = false },
      { "ibhagwan/fzf-lua", cond = false },
      { "folke/flash.nvim", cond = false },
      { "kylechui/nvim-surround", cond = false },
      { "folke/ts-comments.nvim", cond = false },
      { "neovim/nvim-lspconfig", cond = false },
      { "folke/lazydev.nvim", cond = false },
      { "kosayoda/nvim-lightbulb", cond = false },
      { "stevearc/conform.nvim", cond = false },
      { "mfussenegger/nvim-lint", cond = false },
      { "saghen/blink.cmp", cond = false },
      { "saghen/blink.compat", cond = false },
      { "rafamadriz/friendly-snippets", cond = false },
      { "sindrets/diffview.nvim", cond = false },
    }
  or {}
