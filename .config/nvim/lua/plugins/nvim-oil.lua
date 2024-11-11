return { -- File explorer
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    {
      "<C-o>",
      "<cmd>Oil<CR>",
      desc = "[O]pen file explorer in current buffer's directory",
    },
  },
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", cond = vim.g.nerd_font_enabled },
  },
  opts = {
    use_default_keymaps = false,
    view_options = { show_hidden = true },
    keymaps = {
      ["<C-o>"] = "actions.refresh",
      ["gf"] = "actions.select",
      ["gp"] = "actions.parent",
      ["gx"] = "actions.open_external",
      ["gh"] = "actions.toggle_hidden",
      ["<C-e>"] = "actions.close",
      ["<C-\\>"] = "actions.show_help",
    },
  },
}
