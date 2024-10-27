#!/bin/bash -e

# Installs Neovim for Linux systems.
#
# Requires `snapd`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'snapd'..."
sudo apt-get install snapd

echo "Refreshing snap packages..."
sudo snap refresh

echo "Installing Neovim..."
sudo snap install --beta nvim --classic
echo "Installed Neovim successfully!"
