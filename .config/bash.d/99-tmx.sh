# tmx.sh: starts `tmx` in interactive remote shells automatically.
#
# shellcheck shell=bash

command -v tmux &> /dev/null \
  && command -v tmx &> /dev/null \
  && [[ -z "${TMUX}" ]] \
  && [[ $- =~ i ]] \
  && [[ -n "${SSH_TTY}" ]] \
  && tmx
