#!/bin/bash -e
#
# Installs Dropbox for Linux systems.
#
# See headless installation instructions on https://dropbox.com/install-linux.
#
# Requires `wget` and `tar`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly DROPBOX="https://www.dropbox.com/download?plat=lnx.x86_64"

echo "Installing Dropbox..."
cd ~
wget -O - "${DROPBOX}" | tar xzf -
~/.dropbox-dist/dropboxd &> /dev/null &
echo "Installed Dropbox successfully!"
