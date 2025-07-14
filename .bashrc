# ~/.bashrc: executed by `bash` for non-login shells.
#
# shellcheck shell=bash

# Don't do anything if not running interactively.
case $- in
  *i*) ;;
  *) return ;;
esac

# Don't exit the shell on `EOF`.
IGNOREEOF=10

# Save history in XDG-compliant file.
HISTFILE="${XDG_STATE_HOME:-${HOME}/.local/state}/bash_history"

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Set history length.
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary, update the values
# of `LINES` and `COLUMNS`.
shopt -s checkwinsize

# Make `less` more friendly for non-text input files.
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Ensure programmable completion features are enabled.
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

# Load user configs.
for file in "${XDG_CONFIG_HOME:-${HOME}/.config}/bash.d"/*.sh; do
  [[ -f "${file}" ]] && . "${file}"
done
unset file

# If this is an `xterm`, set the title to `user@host:dir`.
case "${TERM}" in
  xterm* | rxvt*) PS1="\[\e]0;\u@\h:\W\a\]${PS1}" ;;
  *) ;;
esac
