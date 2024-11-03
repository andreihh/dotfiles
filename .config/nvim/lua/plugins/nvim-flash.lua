return {
  "folke/flash.nvim", -- Better navigation motions
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
