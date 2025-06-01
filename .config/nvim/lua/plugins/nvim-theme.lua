return { -- Color schemes
  {
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
          -- Override cursor to match terminal.
          Cursor = { fg = colors.base, bg = colors.rosewater },
        }
      end,
      integrations = {
        mason = true,
        signify = true,
        snacks = { enabled = true },
        which_key = true,
      },
    },
  },
  {
    "sainnhe/sonokai",
    priority = 1000, -- Load before all other plugins
    init = function()
      -- Enable italics (supported by most terminals).
      vim.g.sonokai_enable_italic = true
      -- Speed up loading time by loading optimized syntax on-demand.
      vim.g.sonokai_better_performance = true
      vim.api.nvim_create_autocmd("ColorScheme", {
        desc = "Customize Sonokai color scheme",
        group = vim.api.nvim_create_augroup("configure_sonokai_highlights", {}),
        pattern = "sonokai",
        callback = function()
          local config = vim.fn["sonokai#get_configuration"]()
          local set_hl = vim.fn["sonokai#highlight"]
          local palette =
            vim.fn["sonokai#get_palette"](config.style, config.colors_override)

          -- Override window separator to match tab and status lines.
          set_hl("VertSplit", palette.grey_dim, palette.bg1)

          -- Override Snacks dashboard header to match title.
          set_hl("SnacksDashboardHeader", palette.red, palette.none)
        end,
      })
    end,
    opts = {},
  },
}
