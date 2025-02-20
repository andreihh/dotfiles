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
    local lint = require("lint")
    lint.linters = vim.g.lsp.lint.linters
    lint.linters_by_ft = vim.g.lsp.lint.linters_by_ft
  end,
}
