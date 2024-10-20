local lsp_opts = require("config.lsp")

return {
  { -- Formatting
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>=",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format document",
      },
    },
    opts = {
      notify_on_error = false,
      formatters = lsp_opts.formatter_opts or {},
      formatters_by_ft = lsp_opts.formatters_by_ft or {},
    },
  },
}
