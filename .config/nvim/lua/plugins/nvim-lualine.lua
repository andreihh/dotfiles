return { -- Simple and easy statusline
  "nvim-lualine/lualine.nvim",
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", cond = NerdFontEnabled() },
  },
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          function()
            return require("auto-session.lib").current_session_name(true)
          end,
          icon = "󱁿", -- `nf-md-folder-cog`
        },
        { "branch", icon = "" }, -- `nf-fa-code_branch`
        "diagnostics",
      },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
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
    options = vim.tbl_deep_extend("force", {
      -- Show the tabline only if there is more than one tab.
      always_show_tabline = false,
    }, NerdFontEnabled() and {} or { -- Icons require a Nerd Font
      icons_enabled = false,
      component_separators = { left = "│", right = "│" },
      section_separators = "",
    }),
  },
}
