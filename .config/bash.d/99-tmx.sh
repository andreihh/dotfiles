# tmx.sh: starts the `tmx` alias in interactive remote shells automatically.
#
# shellcheck shell=bash

command -v tmux &> /dev/null \
  && command -v tmx &> /dev/null \
  && [[ -z "${TMUX}" ]] \
  && [[ ! "${TERM}" =~ tmux ]] \
  && [[ $- == *i* ]] \
  && [[ -n "${SSH_TTY}" ]] \
  && tmx
