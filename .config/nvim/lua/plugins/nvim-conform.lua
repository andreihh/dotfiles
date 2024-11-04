return { -- Formatting
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format document (selection)",
    },
  },
  opts = {
    notify_on_error = false,
    formatters = vim.g.lsp_opts.formatter_opts or {},
    formatters_by_ft = vim.g.lsp_opts.formatters_by_ft or {},
  },
}
