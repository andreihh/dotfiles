return {
  { -- Colorscheme
    "sainnhe/sonokai",
    -- Load before all other plugins.
    priority = 1000,
    config = function()
      -- Enable italics if the terminal supports it.
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_better_performance = true
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("custom-highlights-sonokai", {}),
        pattern = "sonokai",
        callback = function()
          -- Override window separator to match tab and status lines.
          local config = vim.fn["sonokai#get_configuration"]()
          local palette =
            vim.fn["sonokai#get_palette"](config.style, config.colors_override)
          local set_hl = vim.fn["sonokai#highlight"]
          set_hl("VertSplit", palette.bg1, palette.bg1)
          -- Override lualine theme.
          require("lualine").setup({ options = { theme = "sonokai" } })
        end,
      })
      vim.cmd.colorscheme("sonokai")
    end,
  },
}