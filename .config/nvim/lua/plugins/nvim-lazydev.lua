return {
  { -- Configures LuaLS for Neovim APIs, runtime, plugins, annotations, etc.
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
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
            -- Make `lazydev` completions top priority (see `:h blink.cmp`).
            score_offset = 100,
          },
        },
      },
    },
  },
}
