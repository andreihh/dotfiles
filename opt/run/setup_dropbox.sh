#!/bin/bash -e
#
# Installs Dropbox for Linux or MacOS systems.
#
# See headless installation instructions on https://dropbox.com/install-linux.
#
# Requirements:
# - Linux: `wget`, `tar`
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly DROPBOX="https://www.dropbox.com/download?plat=lnx.x86_64"

echo "Installing Dropbox..."

# Use Homebrew if available.
if command -v brew &> /dev/null; then
  brew install --cask dropbox
else
  cd ~
  wget -O - "${DROPBOX}" | tar xzf -
  ~/.dropbox-dist/dropboxd &> /dev/null &
fi

echo "Installed Dropbox successfully!"
