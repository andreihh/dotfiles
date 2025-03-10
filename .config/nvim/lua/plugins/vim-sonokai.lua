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

        -- Override `fzf-lua` highlights for better contrast.
        vim.cmd([[
          let g:fzf_colors['info'] = ['fg', 'Comment']
          let g:fzf_colors['spinner'] = ['fg', 'Comment']
          let g:fzf_colors['bg+'] = ['bg', 'Pmenu']
        ]])

        -- Override Snacks dashboard header to match title.
        set_hl("SnacksDashboardHeader", palette.red, palette.none)
      end,
    })
    vim.cmd.colorscheme(vim.env.COLORSCHEME)
  end,
}
