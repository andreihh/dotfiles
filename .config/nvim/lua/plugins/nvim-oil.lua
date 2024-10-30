return {
  { -- File explorer
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    keys = {
      {
        "<leader>e",
        "<cmd>Oil<CR>",
        desc = "Open file [E]xplorer in current buffer's directory",
      },
    },
    opts = {
      use_default_keymaps = false,
      view_options = { show_hidden = true },
      keymaps = {
        ["<leader>e"] = "actions.refresh",
        ["gf"] = "actions.select",
        ["gp"] = "actions.parent",
        ["gx"] = "actions.open_external",
        ["gh"] = "actions.toggle_hidden",
        ["<esc>"] = "actions.close",
        ["<C-\\>"] = "actions.show_help",
      },
    },
    dependencies = {
      -- Icons require a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
    },
  },
}
