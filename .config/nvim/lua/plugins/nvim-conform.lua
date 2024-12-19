return { -- Formatting
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "x" },
      desc = "Format document (selection)",
    },
  },
  opts = {
    notify_on_error = false,
    formatters = vim.g.lsp.formatters,
    formatters_by_ft = vim.g.lsp.formatters_by_ft,
  },
}
