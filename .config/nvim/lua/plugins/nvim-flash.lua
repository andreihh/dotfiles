return { -- Better navigation motions
  "folke/flash.nvim",
  -- Ensure enhanced `fFtT;,` motions are configured.
  event = "VeryLazy",
  keys = {
    {
      "<C-f>",
      function()
        require("flash").jump()
      end,
      desc = "Trigger multi-window [F]lash",
    },
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
