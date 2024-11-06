return { -- Better navigation motions
  "folke/flash.nvim",
  keys = {
    {
      "<C-f>",
      function()
        require("flash").jump()
      end,
      mode = { "n", "v" },
      desc = "Trigger Flash",
    },
  },
  config = true,
}
