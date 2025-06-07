return { -- Show gutter sign when code action is available
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = {
    autocmd = { enabled = true },
    number = { enabled = true },
    code_lenses = true,
    sign = {
      text = "󰌵", -- `nf-md-lightbulb`
      lens_text = "󰍉", -- `nf-md-magnify`
    },
  },
}
