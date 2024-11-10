-- Write all buffers before navigating outside of Neovim.
vim.g.tmux_navigator_save_on_switch = 1

-- If Neovim is the zoomed pane, wrap around Neovim instead of unzooming.
vim.g.tmux_navigator_disable_when_zoomed = 1

-- Windows should be resized in increments of 5.
vim.g.tmux_resizer_resize_count = 5
vim.g.tmux_resizer_vertical_resize_count = 5

return { -- Better `tmux` integration
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
  },
  {
    "RyanMillerC/better-vim-tmux-resizer",
    cmd = {
      "TmuxResizeLeft",
      "TmuxResizeDown",
      "TmuxResizeUp",
      "TmuxResizeRight",
    },
    keys = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" },
  },
}
