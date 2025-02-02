#!/bin/bash -e
#
# Installs Alacritty for Linux or MacOS systems.
#
# Requires Homebrew on MacOS.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Alacritty..."

# Use Homebrew if Available.
command -v brew &> /dev/null \
  && brew install --cask alacritty \
  && echo "Installed Alacritty successfully!" \
  && exit 0

echo "Installing Snap..."
sudo apt install snapd

echo "Refreshing Snap packages..."
sudo snap refresh

echo "Installing Alacritty Snap package..."
sudo snap install alacritty --classic
echo "Installed Alacritty successfully!"
