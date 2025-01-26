# fzf_completion.sh: loads `fzf` with completion.
#
# shellcheck shell=bash

# Shell keymaps for `fzf`:
# - <C-r> = search command history
# - **<tab> = complete path / process id / etc.
command -v fzf &> /dev/null && eval "$(fzf --bash)"
