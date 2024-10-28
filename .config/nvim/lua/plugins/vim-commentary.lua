return {
  { -- Commenting lines
    "tpope/vim-commentary",
    cmd = { "Commentary" },
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
