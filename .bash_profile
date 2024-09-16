# ~/.bash_profile: executed by the command interpreter for login shells.
# This file is read by bash(1).
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# The default umask is set in /etc/profile; for setting the umask for ssh
# logins, install and configure the libpam-umask package.
#umask 022

# Include .bashrc if it exists.
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
