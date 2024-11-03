return { -- Better navigation motions
  "folke/flash.nvim",
  keys = {
    {
      "<leader><leader>",
      function()
        require("flash").jump()
      end,
      mode = { "n", "v" },
      desc = "Trigger Flash",
    },
  },
  config = true,
}
