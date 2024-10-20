return {
  { -- Simple and easy statusline
    "nvim-lualine/lualine.nvim",
    dependencies = {
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
    },
    opts = {
      options = {
        -- Set icons_enabled to true if you have a Nerd Font.
        icons_enabled = vim.g.nerd_font_enabled,
      },
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
    },
  },
}
