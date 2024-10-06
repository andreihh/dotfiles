# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything.
case $- in
  *i*) ;;
  *) return ;;
esac

# Save history in XDG-compliant file.
HISTFILE="${XDG_STATE_HOME}/bash_history"

# Don't put duplicate lines or lines starting with space in the history. See
# bash(1) for more options.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1).
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will match all
# files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion features (you don't need to enable this, if
# it's already enabled in /etc/bash.bashrc and /etc/profile sources
# /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Load custom config files:
# - `~/.bash_prompt` for custom shell prompt
# - `~/.bash_aliases` for useful aliases
# - `~/.extras` for device-specific configs
for file in ~/.{bash_prompt,bash_aliases,extras}; do
  [ -f "${file}" ] && . "${file}"
done
unset file

# Load `fzf` with completion.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] \
  && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

# Load `nvm` with completion.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
