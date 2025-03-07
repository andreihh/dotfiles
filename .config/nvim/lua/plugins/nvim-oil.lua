return { -- File explorer
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "g.", "<cmd>Oil<CR>", desc = "[G]oto [.] current buffer's directory" },
  },
  opts = {
    use_default_keymaps = false,
    view_options = { show_hidden = true },
    keymaps = {
      ["g."] = "actions.refresh",
      ["gf"] = "actions.select",
      ["gp"] = "actions.parent",
      ["gx"] = "actions.open_external",
      ["gh"] = "actions.toggle_hidden",
      ["gs"] = "actions.change_sort",
      ["q"] = "actions.close",
      ["g?"] = "actions.show_help",
    },
  },
}
