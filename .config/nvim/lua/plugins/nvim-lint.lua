return { -- Linting
  "mfussenegger/nvim-lint",
  keys = {
    {
      "<leader>l",
      function()
        require("lint").try_lint()
      end,
      desc = "[L]int document and add diagnostics",
    },
  },
  config = function()
    require("lint").linters_by_ft = vim.g.lsp_opts.linters_by_ft or {}
  end,
}
