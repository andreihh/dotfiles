return {
  { -- Commenting lines
    "tpope/vim-commentary",
    lazy = false,
    keys = {
      {
        "<leader>c",
        ":Commentary<CR>",
        mode = { "n", "v" },
        desc = "[C]omment out line or selected range",
      },
    },
  },
}
