return { -- Simple and easy statusline
  "nvim-lualine/lualine.nvim",
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
  },
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        function()
          return require("auto-session.lib").current_session_name(true)
        end,
        "branch",
        "diagnostics",
      },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "encoding", "fileformat", "filetype" },
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
    -- Icons require a Nerd Font.
    options = vim.g.nerd_font_enabled and {
      icons_enabled = true,
    } or {
      icons_enabled = false,
      component_separators = { left = "|", right = "|" },
      section_separators = "",
    },
  },
}
