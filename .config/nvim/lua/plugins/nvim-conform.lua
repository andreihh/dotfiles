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
  opts = vim.tbl_deep_extend("force", {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
    },
  }, vim.g.format_opts or {}),
}
