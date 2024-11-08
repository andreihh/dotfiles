#!/bin/bash
#
# sonokai.tmux: Sonokai colorscheme for `tmux` status line.
#
# Optionally uses Nerd Font symbols. See: https://github.com/sainnhe/sonokai.

tmux set -g @fg "#e2e2e3"  # fg
tmux set -g @reverse_fg "#2c2e34"  # bg0
tmux set -g @highlight_bg "#414550"  # bg4
tmux set -g @pane_fg "#7f8490"  # gray
tmux set -g @current_pane_fg "#76cce0"  # blue
tmux set -g @status_bg "#33353f"  # bg1
tmux set -g @seg_bg "#414550"  # bg4
tmux set -g @current_seg_bg "#ff6077"  # bg_red
tmux set -g @activity_seg_fg "#76cce0"  # blue
tmux set -g @host_seg_bg "#a7df78"  # bg_green

# Icons require a Nerd Font.
if [[ -n "${NERD_FONT_ENABLED}" ]]; then
  tmux set -g @seg_start ""
  tmux set -g @seg_end ""
  tmux set -g @seg_sep ""
  tmux setw -g @win_sep ""
else
  tmux set -g @seg_start ""
  tmux set -g @seg_end ""
  tmux set -g @seg_sep "|"
  tmux set -g @win_sep " "
fi

# Set color scheme.
tmux setw -gF pane-border-style "fg=#{@pane_fg}"
tmux setw -gF pane-active-border-style "fg=#{@current_pane_fg}"
tmux setw -gF mode-style "bg=#{@highlight_bg}"
tmux set -gF message-command-style "bg=#{@highlight_bg}"
tmux set -gF message-style "bg=#{@highlight_bg}"
tmux set -gFa status-style "fg=#{@fg},bg=#{@status_bg}"  # Append to retain bold
tmux set -gFa status-left-style "bg=#{@seg_bg}"  # Append to retain alignment
tmux set -gFa status-right-style "bg=#{@seg_bg}"  # Append to retain alignment
tmux setw -gF window-status-style "bg=#{@seg_bg}"
tmux setw -gF window-status-activity-style "fg=#{@activity_seg_fg}"
tmux setw -gF window-status-current-style "fg=#{@reverse_fg},bg=#{@current_seg_bg}"

# Customize left status segments.
tmux set -g status-left "\
#[fg=#{@reverse_fg},bg=#{@host_seg_bg}] #h \
#[fg=#{@host_seg_bg},bg=default]#{@seg_end}\
#[fg=default] #S \
#[fg=#{@seg_bg},bg=#{@status_bg}]#{@seg_end}"

# Customize right status segments.
tmux set -g status-right "\
#[fg=#{@seg_bg},bg=#{@status_bg}]#{@seg_start}#[fg=default,bg=default]\
#[fg=default] %H:%M \
#[fg=default]#{@seg_sep}\
#{battery_color_fg}#[bg=default] #{battery_icon_status} #{battery_percentage} \
#[fg=default]#{@seg_sep}\
#{cpu_temp_fg_color} T #{cpu_temp} \
#[fg=default]#{@seg_sep}\
#{cpu_fg_color} CPU #{cpu_percentage} \
#[fg=default]#{@seg_sep}\
#{ram_fg_color} RAM #{ram_percentage} "

# Customize window segment separator.
tmux setw -gF window-status-separator "#{@win_sep}"

# Customize window segment.
tmux setw -g window-status-format "\
#[fg=#{@seg_bg},bg=#{@status_bg}]#{@seg_start}#[fg=default,bg=default]\
 #I #{@seg_sep} #W \
#[fg=#{@seg_bg},bg=#{@status_bg}]#{@seg_end}"

# Customize active window segment.
tmux setw -g window-status-current-format "\
#[fg=#{@current_seg_bg},bg=#{@status_bg}]#{@seg_start}#[fg=default,bg=default]\
 #I #{@seg_sep} #W #{@seg_sep} #F \
#[fg=#{@current_seg_bg},bg=#{@status_bg}]#{@seg_end}"
