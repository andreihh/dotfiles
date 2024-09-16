#!/bin/bash

# Installs Dropbox for Linux systems. Requires `wget` and `tar`.
#
# See headless installation instructions on https://dropbox.com/install-linux.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly DROPBOX="https://www.dropbox.com/download?plat=lnx.x86_64"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Dropbox..."
cd ~ && wget -O - "$DROPBOX" | tar xzf - \
  && ~/.dropbox-dist/dropboxd \
  && echo "Installed Dropbox successfully!" \
  || echoerr "Failed to install Dropbox!"
