return { -- Color scheme
  "sainnhe/sonokai",
  priority = 1000, -- Load before all other plugins
  config = function()
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

        -- Override visual highlight to higher contrast.
        set_hl("Visual", palette.none, palette.bg4)
        set_hl("VisualNOS", palette.none, palette.bg4, "underline")
      end,
    })
    if vim.env.COLORSCHEME == "sonokai" then
      vim.cmd.colorscheme("sonokai")
    end
  end,
}
