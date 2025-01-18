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
    icons = {
      -- Icons require a Nerd Font.
      mappings = NerdFontEnabled(),
      -- If you are using a Nerd Font: set icons.keys to an empty table which
      -- will use the default whick-key.nvim defined Nerd Font icons, otherwise
      -- define a string table.
      keys = NerdFontEnabled() and {} or {
        Up = "<Up> ",
        Down = "<Down> ",
        Left = "<Left> ",
        Right = "<Right> ",
        C = "<C-…> ",
        M = "<M-…> ",
        D = "<D-…> ",
        S = "<S-…> ",
        CR = "<CR> ",
        Esc = "<Esc> ",
        ScrollWheelDown = "<ScrollWheelDown> ",
        ScrollWheelUp = "<ScrollWheelUp> ",
        NL = "<NL> ",
        BS = "<BS> ",
        Space = "<Space> ",
        Tab = "<Tab> ",
        F1 = "<F1>",
        F2 = "<F2>",
        F3 = "<F3>",
        F4 = "<F4>",
        F5 = "<F5>",
        F6 = "<F6>",
        F7 = "<F7>",
        F8 = "<F8>",
        F9 = "<F9>",
        F10 = "<F10>",
        F11 = "<F11>",
        F12 = "<F12>",
      },
    },
    -- Trigger only on explicit command or keymap.
    triggers = {},
    -- Document existing key chains.
    spec = {
      { "<leader>", group = "Code" },
      { "g", group = "Goto …" },
      { "[", group = "Jump to previous …" },
      { "]", group = "Jump to next …" },
      { "s", group = "Search" },
      {
        "1",
        group = "Sort ascending",
        icon = "", -- `nf-fa-sort_alpha_asc`
        mode = "x",
      },
      {
        "2",
        group = "Sort descending",
        icon = "", -- `nf-fa-sort_alpha_desc`
        mode = "x",
      },
      { "dm", group = "Delete marks", icon = "󰸕" }, -- `nf-md-bookmark_multiple`
      { "dv", group = "Diff view …", icon = "" }, -- `nf-cod-diff`
      { "M", icon = "" }, -- `nf-fa-plug`
      { "S", icon = "" }, -- `nf-fa-save`
      { "Q", icon = "" }, -- `nf-fa-sign_out`
      { "<C-f>", icon = "" }, -- `nf-fa-flash`
      { "dS", icon = "󱙄" }, -- `nf-md-content_save_off_outline`
      { "H", icon = "󰋗" }, -- `nf-md-help_circle`
      { "<C-s>", icon = "󰋗", mode = "i" }, -- `nf-md-help_circle`
      { "gd", icon = "" }, -- `nf-fa-code`
      { "gD", icon = "" }, -- `nf-fa-code`
      { "gi", icon = "" }, -- `nf-fa-code`
      { "gr", icon = "" }, -- `nf-cod-references`
      { "[r", icon = "" }, -- `nf-cod-references`
      { "]r", icon = "" }, -- `nf-cod-references`
    },
  },
}
