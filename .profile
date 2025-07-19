# ~/.profile: executed by the command interpreter for login shells.
#
# This file is not read by `bash` if `~/.bash_profile` or `~/.bash_login` exist.
#
# shellcheck shell=sh

# Load user environment.
[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/envrc" ] \
  && . "${XDG_CONFIG_HOME:-${HOME}/.config}/envrc"

# Include `.bashrc` if running `bash` and it exists, but only after loading all
# shell-agnostic configs and environment.
[ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
