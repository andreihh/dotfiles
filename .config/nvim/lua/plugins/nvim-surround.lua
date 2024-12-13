return { -- Surround commands
  "kylechui/nvim-surround",
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
  config = true,
}
