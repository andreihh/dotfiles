return {
  { -- Commenting lines
    "tpope/vim-commentary",
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
