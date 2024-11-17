return {
  { -- Neovim / `tmux` window navigation
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate window left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate window down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate window up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate window right" },
    },
    init = function()
      -- Use custom navigation keymaps.
      vim.g.tmux_navigator_no_mappings = 1

      -- Write all buffers before navigating outside of Neovim.
      vim.g.tmux_navigator_save_on_switch = 1

      -- If Neovim is the zoomed pane, wrap around Neovim instead of unzooming.
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  { -- Neovim / `tmux` window resizing
    "RyanMillerC/better-vim-tmux-resizer",
    cmd = {
      "TmuxResizeLeft",
      "TmuxResizeDown",
      "TmuxResizeUp",
      "TmuxResizeRight",
    },
    keys = {
      { "<M-h>", "<cmd>TmuxResizeLeft<CR>", desc = "Resize window left" },
      { "<M-j>", "<cmd>TmuxResizeDown<CR>", desc = "Resize window down" },
      { "<M-k>", "<cmd>TmuxResizeUp<CR>", desc = "Resize window up" },
      { "<M-l>", "<cmd>TmuxResizeRight<CR>", desc = "Resize window right" },
    },
    init = function()
      -- Use custom resizing keymaps.
      vim.g.tmux_resizer_no_mappings = 1

      -- Resize windows in increments of 5.
      vim.g.tmux_resizer_resize_count = 5
      vim.g.tmux_resizer_vertical_resize_count = 5
    end,
  },
}
