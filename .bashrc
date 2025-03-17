# ~/.bashrc: executed by `bash(1)` for non-login shells.
#
# See `/usr/share/doc/bash/examples/startup-files` (in the package bash-doc) for
# examples.
#
# shellcheck shell=bash

# If not running interactively, don't do anything.
case $- in
  *i*) ;;
  *) return ;;
esac

# Don't exit the shell on `EOF`.
IGNOREEOF=10

# Save history in XDG-compliant file.
HISTFILE="${XDG_STATE_HOME:-${HOME}/.local/state}/bash_history"

# Don't put duplicate lines or lines starting with space in the history. See
# `bash(1)` for more options.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# For setting history length see `HISTSIZE` and `HISTFILESIZE` in `bash(1)`.
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary, update the values
# of `LINES` and `COLUMNS`.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will match all
# files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files, see `lesspipe(1)`.
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion features (you don't need to enable this, if
# it's already enabled in `/etc/bash.bashrc` and `/etc/profile` sources
# `/etc/bash.bashrc`).
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /etc/bash_completion
  elif [[ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    # shellcheck source=/dev/null
    . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  fi
fi

# Load user configs.
for file in "${XDG_CONFIG_HOME:-${HOME}/.config}/bash.d"/*; do
  [[ -f "${file}" ]] && . "${file}"
done
unset file
