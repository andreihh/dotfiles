return {
  { -- Treesitter parser manager and installer: `:TSInstall stable unstable`
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate", -- Ensure installed parsers are updated
    opts = {},
  },
  { -- Show current context
    "nvim-treesitter/nvim-treesitter-context",
    cmd = "TSContext",
    opts = { enable = false },
  },
  { -- Select and navigate text objects
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      {
        "ab",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject(
            "@block.outer",
            "textobjects"
          )
        end,
        desc = "Select [A]round [B]lock",
        mode = { "x", "o" },
      },
      {
        "ib",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject(
            "@block.inner",
            "textobjects"
          )
        end,
        desc = "Select [I]nside [B]lock",
        mode = { "x", "o" },
      },
      {
        "am",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject(
            "@function.outer",
            "textobjects"
          )
        end,
        desc = "Select [A]round [M]ethod",
        mode = { "x", "o" },
      },
      {
        "im",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject(
            "@function.inner",
            "textobjects"
          )
        end,
        desc = "Select [I]nside [M]ethod",
        mode = { "x", "o" },
      },
      {
        "]m",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start(
            "@function.outer",
            "textobjects"
          )
        end,
        desc = "Jump to next [M]ethod start",
        mode = { "n", "x", "o" },
      },
      {
        "]M",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end(
            "@function.outer",
            "textobjects"
          )
        end,
        desc = "Jump to next [M]ethod end",
        mode = { "n", "x", "o" },
      },
      {
        "[m",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start(
            "@function.outer",
            "textobjects"
          )
        end,
        desc = "Jump to previous [M]ethod start",
        mode = { "n", "x", "o" },
      },
      {
        "[M",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end(
            "@function.outer",
            "textobjects"
          )
        end,
        desc = "Jump to previous [M]ethod end",
        mode = { "n", "x", "o" },
      },
    },
    opts = {},
  },
  { -- Better comment strings
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
