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
if [ -d "${HOME}/.local/bin" ]; then
  PATH="${HOME}/.local/bin${PATH:+:${PATH}}"
fi

# Load user configs.
for file in "${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d"/*; do
  [ -f "${file}" ] && . "${file}"
done
unset file

# Include `.bashrc` if running bash and it exists, but only after loading all
# shell-agnostic configs and environment.
if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ]; then
  . "${HOME}/.bashrc"
fi
