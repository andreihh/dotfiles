return { -- Simple and easy statusline
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          function()
            return require("auto-session.lib").current_session_name(true)
          end,
          icon = "", -- `nf-fa-folder`
        },
        { "branch", icon = "" }, -- `nf-fa-code_branch`
        "diagnostics",
      },
      lualine_c = { "filename" },
      lualine_x = { "lsp_status", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_a = {
        {
          "tabs",
          max_length = vim.o.columns, -- Span entire tab line
          mode = 2, -- Show tab number and name
          tabs_color = { active = "TabLineSel", inactive = "TabLine" },
        },
      },
    },
    options = {
      -- Show the tabline only if there is more than one tab.
      always_show_tabline = false,
      -- Refresh statusline more frequently for better LSP progress spinner.
      refresh = { statusline = 100 },
    },
    extensions = { "man", "quickfix", "avante" },
  },
}
