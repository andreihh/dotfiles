#!/bin/sh
#
# Loads `tmux` Catppuccin Macchiato theme palette.

tmux set -g @fg '#cad3f5'  # text
tmux set -g @reverse_fg '#24273a'  # base
tmux set -g @highlight_bg '#494d64'  # surface1
tmux set -g @search_bg '#455c6d'  # Neovim Search
tmux set -g @match_bg '#86c5d2'  # Neovim IncSearch
tmux set -g @pane_fg '#6e738d'  # overlay0
tmux set -g @current_pane_fg '#8aadf4'  # blue
tmux set -g @status_bg '#1e2030'  # mantle
tmux set -g @current_seg_bg '#8aadf4'  # blue
tmux set -g @activity_seg_fg '#8aadf4'  # blue
tmux set -g @prefix_highlight_fg '#8aadf4'  # blue
tmux set -g @prefix_highlight_copy_fg '#c6a0f6'  # mauve
tmux set -g @host_fg '#a6da95'  # green
