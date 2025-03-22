#!/bin/bash -e
#
# Installs Alacritty for Linux or MacOS systems.
#
# Requirements:
# - Linux: Snap, `git`
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly THEMES_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/alacritty/themes"

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

[[ ! -d "${THEMES_DIR}" ]] \
  && echo "Cloning Alacritty themes..." \
  && mkdir -p "${THEMES_DIR}" \
  && git clone https://github.com/alacritty/alacritty-theme "${THEMES_DIR}"

echo "Installed Alacritty successfully!"
