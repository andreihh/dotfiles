# ~/.profile: executed by the command interpreter for login shells.
#
# This file is not read by `bash(1)`, if `~/.bash_profile` or `~/.bash_login`
# exists.
#
# See `/usr/share/doc/bash/examples/startup-files` for examples. The files are
# located in the bash-doc package.
#
# shellcheck shell=sh

# Set `PATH` so it includes user's private `bin` if it exists.
[ -d "${HOME}"/.local/bin ] && PATH="${HOME}/.local/bin${PATH:+:${PATH}}"

# Load user configs.
for file in "${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d"/*.sh; do
  [ -f "${file}" ] && . "${file}"
done
unset file

# Include `.bashrc` if running bash and it exists, but only after loading all
# shell-agnostic configs and environment.
[ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
