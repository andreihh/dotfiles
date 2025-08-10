# ~/.profile: executed by the command interpreter for login shells.
#
# This file is not read by `bash` if `~/.bash_profile` or `~/.bash_login` exist.
#
# shellcheck shell=sh

# Load user environment.
[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/envrc" ] \
  && . "${XDG_CONFIG_HOME:-${HOME}/.config}/envrc"

# Include `.bashrc` if running `bash`, but only after loading the environment.
[ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
