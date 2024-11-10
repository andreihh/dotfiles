return { -- Show gutter sign when code action is available
  "kosayoda/nvim-lightbulb",
  event = "VeryLazy",
  opts = {
    autocmd = { enabled = true },
    number = { enabled = true },
    -- Decrease gutter sign priority below diagnostic signs (default 10).
    priority = 9,
    -- Icons require a Nerd Font.
    sign = { text = vim.g.nerd_font_enabled and "󰌵" or "A" },
  },
}
