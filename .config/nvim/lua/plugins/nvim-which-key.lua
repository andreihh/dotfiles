return { -- Useful plugin to show pending keybinds
  "folke/which-key.nvim",
  cmd = "WhichKey",
  keys = {
    {
      "<C-\\>",
      "<cmd>WhichKey<CR>",
      mode = { "n", "i", "x", "s", "o", "t", "c" },
      desc = "Show keymaps (which-key)",
    },
  },
  opts = {
    triggers = {}, -- Trigger only on explicit command or keymap
    spec = {
      { "<leader>", group = "Code" },
      { "g", group = "Goto …" },
      { "[", group = "Jump to previous …" },
      { "]", group = "Jump to next …" },
      { "s", group = "Sort", icon = "", mode = "x" }, -- `nf-fa-sort_alpha_asc`
      { "s", group = "Search" },
      { "dm", group = "Delete marks", icon = "󰸕" }, -- `nf-md-bookmark_multiple`
      { "dv", group = "Diff view", icon = "" }, -- `nf-cod-diff`
      { "M", icon = "" }, -- `nf-fa-plug`
      { "S", icon = "" }, -- `nf-fa-save`
      { "Q", icon = "" }, -- `nf-fa-sign_out`
      { "<C-f>", icon = "" }, -- `nf-fa-flash`
      { "dS", icon = "󱙄" }, -- `nf-md-content_save_off_outline`
      { "gd", icon = "" }, -- `nf-fa-code`
      { "gD", icon = "" }, -- `nf-fa-code`
      { "gi", icon = "" }, -- `nf-fa-code`
      { "gr", icon = "" }, -- `nf-cod-references`
      { "[r", icon = "" }, -- `nf-cod-references`
      { "]r", icon = "" }, -- `nf-cod-references`
      { "H", icon = "" }, -- `nf-fa-question`
      { "<C-s>", icon = "", mode = "i" }, -- `nf-fa-question`
    },
  },
}
