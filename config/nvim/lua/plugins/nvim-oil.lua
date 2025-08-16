return { -- File explorer
  "stevearc/oil.nvim",
  lazy = false, -- Ensure auto-loading
  cmd = "Oil",
  keys = { { "g-", "<cmd>Oil<CR>", desc = "[G]oto [-] parent directory" } },
  opts = {
    use_default_keymaps = false,
    view_options = { show_hidden = true },
    keymaps = {
      ["g-"] = "actions.parent",
      ["gf"] = "actions.select",
      ["gx"] = "actions.open_external",
      ["gh"] = "actions.toggle_hidden",
      ["gs"] = "actions.change_sort",
      ["gr"] = "actions.refresh",
      ["q"] = "actions.close",
      ["g?"] = "actions.show_help",
    },
  },
}
