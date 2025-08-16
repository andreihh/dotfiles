return { -- Useful plugin to show pending keybinds
  "folke/which-key.nvim",
  cmd = "WhichKey",
  keys = {
    {
      "<M-/>",
      "<cmd>WhichKey<CR>",
      mode = { "n", "i", "x", "s", "o", "t", "c" },
      desc = "Show keymaps (which-key)",
    },
  },
  opts = {
    triggers = {}, -- Trigger only on explicit command or keymap
    spec = {
      { "<leader><leader>", group = "AI", mode = { "n", "x" } },
      { "g", group = "Goto …" },
      { "[", group = "Jump to previous …" },
      { "]", group = "Jump to next …" },
      { "s", group = "Search" },
      { "s", group = "Sort", icon = "", mode = "x" }, -- `nf-fa-sort_alpha_asc`
      { "dm", group = "Delete marks", icon = "󰸕" }, -- `nf-md-bookmark_multiple`
      { "<leader>t", group = "Toggle options" },
      { "<leader>v", group = "VCS", icon = "" }, -- `nf-fa-code_branch`
      { "<leader>V", icon = "" }, -- `nf-fa-code_branch`
      { "<leader>P", icon = "" }, -- `nf-fa-plug`
      { "<leader>S", icon = "" }, -- `nf-fa-save`
      { "S", icon = "" }, -- `nf-fa-save`
      { "Q", icon = "" }, -- `nf-fa-sign_out`
      { "q", icon = "" }, -- `nf-fa-sign_out`
      { "<C-f>", icon = "" }, -- `nf-fa-flash`
      { "dS", icon = "󱙄" }, -- `nf-md-content_save_off_outline`
      { "g-", icon = "" }, -- `nf-fa-folder`
      { "gd", icon = "" }, -- `nf-fa-code`
      { "gD", icon = "" }, -- `nf-fa-code`
      { "gi", icon = "" }, -- `nf-fa-code`
      { "gr", icon = "" }, -- `nf-cod-references`
      { "[r", icon = "" }, -- `nf-cod-references`
      { "]r", icon = "" }, -- `nf-cod-references`
      { "H", icon = "" }, -- `nf-fa-question`
      { "<C-s>", icon = "", mode = "i" }, -- `nf-fa-question`
      { "<leader>cc", icon = "" }, -- `nf-fa-code`
      { "<leader>c", icon = "", mode = { "n", "x" } }, -- `nf-fa-code`
      { "<leader>f", icon = "" }, -- `nf-fa-code`
      { "<leader>r", icon = "" }, -- `nf-fa-code`
    },
  },
}
