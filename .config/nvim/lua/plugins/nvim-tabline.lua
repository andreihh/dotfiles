return {
  { -- Decorate tabline with tab index, icon, etc.
    "crispgm/nvim-tabline",
    dependencies = {
      -- Icons require a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
    },
    -- Icons require a Nerd Font.
    opts = { show_icon = vim.g.nerd_font_enabled },
  },
}
