return { -- Linting
  "mfussenegger/nvim-lint",
  keys = {
    {
      "<leader>l",
      function()
        require("lint").try_lint()
      end,
      desc = "[L]int and add diagnostics",
    },
    {
      "<leader>L",
      vim.diagnostic.reset,
      desc = "Clear [L]ints and diagnostics",
    },
  },
  config = function()
    require("lint").linters_by_ft = vim.g.lsp.linters_by_ft
  end,
}
