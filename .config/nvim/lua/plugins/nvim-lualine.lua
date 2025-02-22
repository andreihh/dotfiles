return { -- Simple and easy statusline
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "session",
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
    -- Show the tabline only if there is more than one tab.
    options = { always_show_tabline = false },
  },
}
