#!/bin/bash -e
#
# Installs Alacritty for Linux or MacOS systems.
#
# Requirements:
# - Linux: Snap, `git`
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly THEMES_DIR="${XDG_CONFIG_HOME:?}/alacritty/themes"

echo "Installing Alacritty..."

# Use Homebrew if available.
if command -v brew &> /dev/null; then
  brew install --cask alacritty
else
  snap install alacritty --classic
fi

[[ ! -d "${THEMES_DIR}" ]] \
  && echo "Cloning Alacritty themes..." \
  && mkdir -p "${THEMES_DIR}" \
  && git clone --depth=1 https://github.com/alacritty/alacritty-theme \
    "${THEMES_DIR}"

echo "Installed Alacritty successfully!"
