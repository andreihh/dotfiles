return {
  { -- Configures LuaLS for Neovim APIs, runtime, plugins, annotations, etc.
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        -- Load `luvit` types when the `vim.uv` word is found.
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- Load `snacks` types when the `Snacks` word is found.
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  -- Manage `luvit` types with Lazy. Plugin will never be loaded.
  { "Bilal2453/luvit-meta", lazy = true },
  { -- Completion source for `require` statements and module annotations
    "saghen/blink.cmp",
    opts = {
      sources = {
        completion = { enabled_providers = { "lazydev" } },
        providers = {
          -- Don't show LuaLS `require` statements when `lazydev` has items.
          lsp = { fallback_for = { "lazydev" } },
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
      },
    },
  },
}
