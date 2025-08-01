#!/bin/sh
#
# Loads `tmux` Catppuccin Mocha theme palette.

tmux set -g @fg '#cdd6f4'  # text
tmux set -g @reverse_fg '#1e1e2e'  # base
tmux set -g @highlight_bg '#45475a'  # surface1
tmux set -g @search_bg '#3e5767'  # Neovim Search
tmux set -g @match_bg '#7ec9d8'  # Neovim IncSearch
tmux set -g @pane_fg '#6c7086'  # overlay0
tmux set -g @current_pane_fg '#89b4fa'  # blue
tmux set -g @status_bg '#181825'  # mantle
tmux set -g @current_seg_bg '#89b4fa'  # blue
tmux set -g @activity_seg_fg '#89b4fa'  # blue
tmux set -g @prefix_highlight_fg '#89b4fa'  # blue
tmux set -g @prefix_highlight_copy_fg '#cba6f7'  # mauve
tmux set -g @host_fg '#a6e3a1'  # green
