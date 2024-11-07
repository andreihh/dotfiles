return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis.
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found.
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  { -- Completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local sources = opts.sources or {}
      -- Set group index to 0 to skip loading Lua LS completions.
      table.insert(sources, { name = "lazydev", group_index = 0 })
      return vim.tbl_deep_extend("force", opts, {
        sources = sources,
        formatting = { format = { menu = { lazydev = "[API]" } } },
      })
    end,
  },
}
