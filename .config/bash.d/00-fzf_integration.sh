# fzf_integration.sh: loads `fzf` shell integration.
#
# shellcheck shell=bash

# Shell keymaps for `fzf`:
# - <C-r> = search command history
# - **<tab> = complete path / process id / etc.
command -v fzf &> /dev/null && eval "$(fzf --bash)"

# Interactive prompt should match shell prompt.
alias fzf='fzf --color=prompt:green:bold'
export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --color=prompt:green:bold"
export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} --color=prompt:green:bold"
export FZF_ALT_C_OPTS="${FZF_ALT_C_OPTS} --color=prompt:green:bold"
