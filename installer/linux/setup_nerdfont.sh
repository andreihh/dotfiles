#!/bin/bash -e

# Installs Neovim for Linux systems.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly FONT_ZIP="JetBrainsMono.zip"
readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_ZIP"

echo "Installing 'JetBrainsMono' font..."

echo "Downloading 'JetBrainsMono'..."
wget -P "$XDG_DATA_HOME/fonts" "$FONT_URL"
cd "$XDG_DATA_HOME/fonts"

echo "Unpacking 'JetBrainsMono'..."
unzip "$FONT_ZIP"
rm "$FONT_ZIP"

echo "Refreshing font cache..."
fc-cache -fv

echo "Installed 'JetBrainsMono' successfully!"
