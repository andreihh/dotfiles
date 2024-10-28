return {
  { -- Useful plugin to show pending keybinds
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    keys = {
      {
        "<C-\\>",
        function()
          require("which-key").show({ global = true })
        end,
        mode = { "n", "i", "v" },
        desc = "Show buffer local keymaps (which-key)",
      },
    },
    opts = {
      icons = {
        -- Icons require a Nerd Font.
        mappings = vim.g.nerd_font_enabled,
        -- If you are using a Nerd Font: set icons.keys to an empty table which
        -- will use the default whick-key.nvim defined Nerd Font icons,
        -- otherwise define a string table.
        keys = vim.g.nerd_font_enabled and {} or {
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
      -- Document existing key chains.
      spec = {
        { "<leader>", group = "Code", mode = { "n" } },
        { "g", group = "[G]o to …", mode = { "n", "v" } },
        { "s", group = "[S]earch with Telescope", mode = { "n" } },
        { "[", group = "Jump to previous …", mode = { "n" } },
        { "]", group = "Jump to next …", mode = { "n" } },
      },
    },
  },
}
