return {
  { -- File explorer
    "stevearc/oil.nvim",
    opts = {
      use_default_keymaps = false,
      view_options = { show_hidden = true },
      keymaps = {
        ["gf"] = "actions.select",
        ["gp"] = "actions.parent",
        ["gx"] = "actions.open_external",
        ["th"] = "actions.toggle_hidden",
        ["<C-l>"] = "actions.refresh",
        ["<C-e>"] = "actions.close",
        ["<C-\\>"] = "actions.show_help",
      },
    },
    dependencies = {
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
    },
  },
}
