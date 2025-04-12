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
      sh = { "shfmt" },
      lua = { "stylua" },
      yaml = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
    },
  }, vim.g.format_opts or {}),
}
