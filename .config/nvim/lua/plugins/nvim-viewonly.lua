-- Disable plugins for view-only mode (diff, read-only, non-modifiable).
return (vim.o.diff or vim.o.readonly or not vim.o.modifiable)
    and { -- Keep sorted
      { "folke/flash.nvim", cond = false },
      { "folke/lazydev.nvim", cond = false },
      { "folke/ts-comments.nvim", cond = false },
      { "ibhagwan/fzf-lua", cond = false },
      { "kosayoda/nvim-lightbulb", cond = false },
      { "kylechui/nvim-surround", cond = false },
      { "mfussenegger/nvim-lint", cond = false },
      { "neovim/nvim-lspconfig", cond = false },
      { "rafamadriz/friendly-snippets", cond = false },
      { "rmagatti/auto-session", cond = false },
      { "saghen/blink.cmp", cond = false },
      { "saghen/blink.compat", cond = false },
      { "sindrets/diffview.nvim", cond = false },
      { "stevearc/conform.nvim", cond = false },
      { "stevearc/oil.nvim", cond = false },
    }
  or {}
