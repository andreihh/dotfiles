# fzf_integration.sh: loads `fzf` integration.
#
# Must be loaded after any changes required to ensure `fzf` is on the `PATH`.
# Keymaps are supported only for `bash` and `zsh`.
#
# shellcheck shell=sh

if command -v fzf > /dev/null 2>&1; then
  # Shell keymaps for `fzf`:
  # - <C-r> = search command history
  # - **<tab> = complete path / process id / etc.
  [ -n "${BASH_VERSION}" ] && eval "$(fzf --bash)"
  [ -n "${ZSH_VERSION}" ] && eval "$(fzf --zsh)"

  # Shell prompt should match the `fzf` prompt.
  alias fzf='fzf --color=prompt:green:bold'
  export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --color=prompt:green:bold"
  export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} --color=prompt:green:bold"
  export FZF_ALT_C_OPTS="${FZF_ALT_C_OPTS} --color=prompt:green:bold"
fi
