# fzf_integration.sh: loads `fzf` integration.
#
# Must be loaded after any changes required to ensure `fzf` is on the `PATH`.
# Keymaps are supported only for `bash` and `zsh`.
#
# shellcheck shell=sh

if command -v fzf > /dev/null 2>&1; then
  # Keymaps:
  # - <C-r> = search command history
  # - **<tab> = complete path / process id / etc.
  [ -n "${BASH_VERSION}" ] && eval "$(fzf --bash)"
  [ -n "${ZSH_VERSION}" ] && eval "$(fzf --zsh)"

  # `fzf` prompt should match the shell prompt for completions.
  export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --color=prompt:green:bold"
  export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} --color=prompt:green:bold"
  export FZF_ALT_C_OPTS="${FZF_ALT_C_OPTS} --color=prompt:green:bold"
  export FZF_COMPLETION_OPTS="${FZF_COMPLETION_OPTS} --color=prompt:green:bold"

  if [ -n "${TMUX}" ]; then
    # Use `fzf-tmux` instead of `fzf` for completions inside `tmux`.
    export FZF_TMUX=1
    export FZF_TMUX_OPTS="${FZF_TMUX_OPTS} -d 80%"
  fi
fi
