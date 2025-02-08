#!/bin/bash -e
#
# Installs Alacritty for Linux or MacOS systems.
#
# Requirements:
# - Linux: Snap
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Alacritty..."

# Use Homebrew if available.
command -v brew &> /dev/null \
  && brew install --cask alacritty \
  && echo "Installed Alacritty successfully!" \
  && exit 0

echo "Installing Snap..."
sudo apt install -y snapd

echo "Refreshing Snap packages..."
sudo snap refresh

echo "Installing Alacritty Snap package..."
sudo snap install alacritty --classic
echo "Installed Alacritty successfully!"
