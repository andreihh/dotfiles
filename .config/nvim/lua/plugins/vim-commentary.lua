return {
  { -- Commenting lines
    "tpope/vim-commentary",
    cmd = { "Commentary" },
    keys = {
      {
        "<leader>-",
        ":Commentary<CR>",
        mode = { "n", "v" },
        desc = "Comment out line or selected range",
      },
    },
  },
}
