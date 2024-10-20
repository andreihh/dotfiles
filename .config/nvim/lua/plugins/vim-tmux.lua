-- Write all buffers before navigating outside of Neovim.
vim.g.tmux_navigator_save_on_switch = 1

-- If Neovim is the zoomed pane, wrap around Neovim instead of unzooming.
vim.g.tmux_navigator_disable_when_zoomed = 1

-- Windows should be resized in increments of 5.
vim.g.tmux_resizer_resize_count = 5
vim.g.tmux_resizer_vertical_resize_count = 5

return {
  "christoomey/vim-tmux-navigator", -- Navigate panes across Vim and `tmux`
  "RyanMillerC/better-vim-tmux-resizer", -- Resize panes across Vim and `tmux`
}
