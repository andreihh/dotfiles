return {
  { -- Highlighting and jumping to references
    "RRethy/vim-illuminate",
    event = { "VeryLazy" },
    keys = {
      {
        "[r",
        function()
          require("illuminate").goto_prev_reference()
        end,
        mode = "n",
        desc = "Jump to previous [R]eference",
      },
      {
        "]r",
        function()
          require("illuminate").goto_next_reference()
        end,
        mode = "n",
        desc = "Jump to next [R]eference",
      },
    },
  },
}
