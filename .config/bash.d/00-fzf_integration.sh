# fzf_integration.sh: loads `fzf` shell integration.
#
# shellcheck shell=bash

# Shell keymaps for `fzf`:
# - <C-r> = search command history
# - **<tab> = complete path / process id / etc.
command -v fzf &> /dev/null && eval "$(fzf --bash)"
