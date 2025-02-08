#!/bin/bash -e
#
# Installs `JetBrainsMono` Nerd Font for Linux or MacOS systems.
#
# The font is required for terminals other than Ghostty, which has this font
# built in.
#
# Requirements:
# - Linux: `wget`, `unzip`, `fontconfig`
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly FONT_ZIP="JetBrainsMono.zip"
readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"
readonly FONTS_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/fonts"

echo "Installing 'JetBrainsMono' font..."

# Use Homebrew if available.
command -v brew &> /dev/null \
  && brew install --cask font-jetbrains-mono-nerd-font \
  && echo "Installed 'JetBrainsMono' successfully!" \
  && exit 0

echo "Installing 'fontconfig'..."
sudo apt install -y fontconfig

echo "Downloading 'JetBrainsMono'..."
wget -P "${FONTS_DIR}" "${FONT_URL}"
cd "${FONTS_DIR}"

echo "Unpacking 'JetBrainsMono'..."
unzip "${FONT_ZIP}"
rm "${FONT_ZIP}"

echo "Refreshing font cache..."
fc-cache -fv

echo "Installed 'JetBrainsMono' successfully!"
