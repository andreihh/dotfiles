return { -- Show gutter sign when code action is available
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = {
    autocmd = { enabled = true },
    number = { enabled = true },
    priority = 9, -- Decrease sign priority below diagnostic signs (default 10)
    sign = { text = "󰌵" }, -- `nf-md-lightbulb`
  },
}
