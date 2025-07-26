return { -- Catppuccin color scheme
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Load before all other plugins
  opts = {
    show_end_of_buffer = true,
    styles = { conditionals = {} }, -- Don't use italic for conditionals
    custom_highlights = function(colors)
      return {
        -- Override window separator to match status line.
        WinSeparator = { fg = colors.overlay0, bg = colors.mantle },
        -- Override float border to match window separator.
        FloatBorder = { fg = colors.overlay0 },
        -- Override background for float windows that have backdrop.
        LazyNormal = { fg = colors.text, bg = colors.base },
        MasonNormal = { fg = colors.text, bg = colors.base },
        SnacksNormal = { fg = colors.text, bg = colors.base },
        FzfLuaNormal = { fg = colors.text, bg = colors.base },
        FzfLuaTitle = { fg = colors.blue, bg = colors.base },
        FzfLuaBorder = { fg = colors.overlay0, bg = colors.base },
      }
    end,
    integrations = {
      mason = true,
      signify = true,
      snacks = { enabled = true },
      which_key = true,
    },
  },
}
