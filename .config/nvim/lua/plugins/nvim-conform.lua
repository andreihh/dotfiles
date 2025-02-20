return { -- Formatting
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "x" },
      desc = "Format",
    },
  },
  opts = vim.g.lsp.format,
}
