return {
  { -- Configures LuaLS for Neovim APIs, runtime, plugins, annotations, etc.
    "folke/lazydev.nvim",
    cmd = "LazyDev",
    ft = "lua",
    opts = {
      library = {
        -- Load `luvit` types when the `vim.uv` word is found.
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Load `snacks` types when the `Snacks` word is found.
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  { -- Completion source for `require` statements and module annotations
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- Make `lazydev` completions top priority
          },
        },
      },
    },
  },
}
