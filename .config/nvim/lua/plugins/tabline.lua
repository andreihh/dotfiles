return {
  { -- Decorate tabline with tab index, icon, etc.
    "crispgm/nvim-tabline",
    dependencies = {
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
    },
    opts = {
      -- Set show_icon to true if you have a Nerd Font.
      show_icon = vim.g.nerd_font_enabled,
    },
  },
}
