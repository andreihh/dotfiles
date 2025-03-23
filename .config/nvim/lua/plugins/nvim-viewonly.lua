-- Disable plugins for view-only mode (diff, read-only, non-modifiable).
local is_viewonly = false
for _, option in ipairs({ "-d", "-R", "-m", "-M" }) do
  is_viewonly = is_viewonly or vim.list_contains(vim.v.argv, option)
end

return is_viewonly
    and { -- Keep sorted
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
      { "saghen/blink.compat", cond = false },
      { "sindrets/diffview.nvim", cond = false },
      { "stevearc/conform.nvim", cond = false },
    }
  or {}
