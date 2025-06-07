return { -- Better navigation motions
  "folke/flash.nvim",
  keys = {
    {
      "<C-f>",
      function()
        require("flash").jump()
      end,
      desc = "Multi-window Flash [F]ind",
    },
    { "f", mode = { "n", "x", "o" } },
    { "F", mode = { "n", "x", "o" } },
    { "t", mode = { "n", "x", "o" } },
    { "T", mode = { "n", "x", "o" } },
    { ";", mode = { "n", "x", "o" } },
    { ",", mode = { "n", "x", "o" } },
  },
  opts = {
    modes = {
      char = {
        jump_labels = true,
        jump = { autojump = true },
      },
    },
  },
}
