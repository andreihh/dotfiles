return { -- Better navigation motions
  "folke/flash.nvim",
  keys = {
    {
      "<C-f>",
      function()
        require("flash").jump()
      end,
      desc = "Trigger multi-window [F]lash",
    },
    { "f", mode = { "n", "v" } },
    { "F", mode = { "n", "v" } },
    { "t", mode = { "n", "v" } },
    { "T", mode = { "n", "v" } },
    { ";", mode = { "n", "v" } },
    { ",", mode = { "n", "v" } },
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
