return { -- Colorscheme
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
        local config = vim.fn["sonokai#get_configuration"]()
        local palette =
          vim.fn["sonokai#get_palette"](config.style, config.colors_override)
        local set_hl = vim.fn["sonokai#highlight"]

        -- Override window separator to match tab and status lines.
        set_hl("VertSplit", palette.grey_dim, palette.bg1)

        -- Override visual highlight to higher contrast.
        set_hl("Visual", palette.none, palette.bg4)
        set_hl("VisualNOS", palette.none, palette.bg4, "underline")

        -- Override lualine theme.
        require("lualine").setup({ options = { theme = "sonokai" } })
      end,
    })
    if vim.env.COLORSCHEME == "sonokai" then
      vim.cmd.colorscheme("sonokai")
    end
  end,
}
