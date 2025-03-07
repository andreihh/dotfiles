#!/bin/bash
#
# sonokai.tmux: Sonokai color scheme for `tmux`.
#
# See https://github.com/sainnhe/sonokai.

# Configure color palette.
tmux set -g @fg '#e2e2e3'  # fg
tmux set -g @reverse_fg '#2c2e34'  # bg0
tmux set -g @highlight_bg '#414550'  # bg4
tmux set -g @search_bg '#a7df78'  # bg_green
tmux set -g @match_bg '#ff6077'  # bg_red
tmux set -g @pane_fg '#595f6f'  # gray_dim
tmux set -g @current_pane_fg '#76cce0'  # blue
tmux set -g @status_bg '#33353f'  # bg1
tmux set -g @current_seg_bg '#ff6077'  # bg_red
tmux set -g @activity_seg_fg '#76cce0'  # blue
tmux set -g @prefix_highlight_fg '#76cce0'  # blue
tmux set -g @prefix_highlight_copy_fg '#fc5d7c'  # red
tmux set -g @host_fg '#9ed072'  # green
