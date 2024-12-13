return { -- Better surround motions
  "tpope/vim-surround",
  keys = {
    { "ys" },
    { "yss" },
    { "yS" },
    { "ySS" },
    { "ds" },
    { "cs" },
    { "cS" },
    { "S", mode = "x" },
    { "gS", mode = "x" },
    { "<C-g>s", mode = "i" },
    { "<C-g>S", mode = "i" },
  },
}
