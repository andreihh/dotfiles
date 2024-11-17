# ~/.profile: executed by the command interpreter for login shells.
#
# This file is not read by `bash(1)`, if `~/.bash_profile` or `~/.bash_login`
# exists.
#
# See `/usr/share/doc/bash/examples/startup-files` for examples. The files are
# located in the bash-doc package.
#
# shellcheck shell=sh

# The default umask is set in `/etc/profile`; for setting the umask for ssh
# logins, install and configure the `libpam-umask` package.
#umask 022

# If running bash.
if [ -n "${BASH_VERSION}" ]; then
  # Include `.bashrc` if it exists.
  if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
  fi
fi

# Set PATH so it includes user's private bin if it exists.
if [ -d "${HOME}/bin" ]; then
  PATH="${HOME}/bin${PATH:+:${PATH}}"
fi

# Set `PATH` so it includes user's private `bin` if it exists.
if [ -d "${HOME}/.local/bin" ]; then
  PATH="${HOME}/.local/bin${PATH:+:${PATH}}"
fi

# Load user configs.
for file in "${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d"/*; do
  [ -f "${file}" ] && . "${file}"
done
unset file
