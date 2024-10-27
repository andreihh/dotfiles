#!/bin/bash -e

# Installs `JetBrainsMono` Nerd Font for Linux systems.
#
# Requires `wget`, `unzip` and `fontconfig`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly FONT_ZIP="JetBrainsMono.zip"
readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"
readonly FONTS_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/fonts"

echo "Installing 'JetBrainsMono' font..."

echo "Downloading 'JetBrainsMono'..."
wget -P "${FONTS_DIR}" "${FONT_URL}"
cd "${FONTS_DIR}"

echo "Unpacking 'JetBrainsMono'..."
unzip "${FONT_ZIP}"
rm "${FONT_ZIP}"

echo "Refreshing font cache..."
fc-cache -fv

echo "Installed 'JetBrainsMono' successfully!"
