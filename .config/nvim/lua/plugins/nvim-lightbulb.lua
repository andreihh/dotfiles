return { -- Show gutter sign when code action is available
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = {
    autocmd = { enabled = true },
    number = { enabled = true },
    -- Decrease gutter sign priority below diagnostic signs (default 10).
    priority = 9,
    -- Icons require a Nerd Font.
    sign = { text = NerdFontEnabled() and "󰌵" or "A" }, -- `nf-md-lightbulb`
  },
}
