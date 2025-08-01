#!/bin/sh
#
# Loads `tmux` Catppuccin Frappe theme palette.

tmux set -g @fg '#c6d0f5'  # text
tmux set -g @reverse_fg '#303446'  # base
tmux set -g @highlight_bg '#51576d'  # surface1
tmux set -g @search_bg '#506373'  # Neovim Search
tmux set -g @match_bg '#8fc1cc'  # Neovim IncSearch
tmux set -g @pane_fg '#737994'  # overlay0
tmux set -g @current_pane_fg '#8caaee'  # blue
tmux set -g @status_bg '#292c3c'  # mantle
tmux set -g @current_seg_bg '#8caaee'  # blue
tmux set -g @activity_seg_fg '#8caaee'  # blue
tmux set -g @prefix_highlight_fg '#8caaee'  # blue
tmux set -g @prefix_highlight_copy_fg '#ca9ee6'  # mauve
tmux set -g @host_fg '#a6d189'  # green
