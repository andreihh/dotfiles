return { -- Provides Nerd Font icons for plugins
  "nvim-tree/nvim-web-devicons",
  lazy = true, -- Will be loaded on demand by dependants
  cond = NerdFontEnabled(), -- Icons require a Nerd Font
  config = true,
}
