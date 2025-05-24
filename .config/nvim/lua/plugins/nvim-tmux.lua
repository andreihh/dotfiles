return { -- `tmux` integration for window navigation and resizing
  "aserowy/tmux.nvim",
  keys = {
    { "<C-h>", desc = "Navigate window left" },
    { "<C-j>", desc = "Navigate window down" },
    { "<C-k>", desc = "Navigate window up" },
    { "<C-l>", desc = "Navigate window right" },
    { "<M-h>", desc = "Resize window left" },
    { "<M-j>", desc = "Resize window down" },
    { "<M-k>", desc = "Resize window up" },
    { "<M-l>", desc = "Resize window right" },
  },
  opts = {
    -- Disable `tmux` copy sync because Neovim already uses system clipboard.
    copy_sync = { enable = false },
    navigation = {
      enable_default_keybindings = true,
      -- If Neovim is the zoomed `tmux` pane, wrap around instead of unzooming.
      persist_zoom = true,
    },
    resize = {
      enable_default_keybindings = true,
      -- Resize windows in increments of 5.
      resize_step_x = 5,
      resize_step_y = 5,
    },
    swap = { enable_default_keybindings = false },
  },
}
