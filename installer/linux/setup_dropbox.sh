#!/bin/bash

# Installs Dropbox for Linux systems.
#
# Requires `wget` and `tar`.
#
# See headless installation instructions on https://dropbox.com/install-linux.

readonly DROPBOX="https://www.dropbox.com/download?plat=lnx.x86_64"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Dropbox..."
if cd ~ && wget -O - "$DROPBOX" | tar xzf - && ~/.dropbox-dist/dropboxd; then
  echo "Installed Dropbox successfully!"
else
  echo "Failed to install Dropbox!"
  exit 1
fi
