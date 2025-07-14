# fzf_prompt.sh: configures `fzf` prompt.
#
# shellcheck shell=sh

if command -v fzf > /dev/null 2>&1; then
  # Shell prompt should match the `fzf` prompt.
  alias fzf='fzf --color=prompt:green:bold'
  export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --color=prompt:green:bold"
  export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} --color=prompt:green:bold"
  export FZF_ALT_C_OPTS="${FZF_ALT_C_OPTS} --color=prompt:green:bold"
fi
