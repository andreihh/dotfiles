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
    lint.linters = vim.g.lint_opts.linters or {}
    lint.linters_by_ft = vim.g.lint_opts.linters_by_ft or {}
  end,
}
