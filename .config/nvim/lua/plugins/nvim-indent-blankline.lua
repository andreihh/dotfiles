return { -- Show indent guide
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  opts = {
    scope = { enabled = false },
    -- Disable in big files.
    exclude = { filetypes = { "bigfile" } },
  },
}
