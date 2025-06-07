#!/bin/bash -e
#
# Installs Catppuccin themes.
#
# See https://catppuccin.com.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies: `git`, `wget`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly THEME_GIT_URL='https://github.com/catppuccin'
readonly THEME_CURSORS_URL="${THEME_GIT_URL}/cursors/releases/latest/download"
readonly THEME_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/catppuccin"

echo "Installing Catppuccin..."

echo "Cleaning up prior Catppuccin installation..."
rm -rf "${THEME_HOME}"

echo "Downloading Catppuccin themes..."
mkdir -p "${THEME_HOME}"
cd "${THEME_HOME}"
echo alacritty fzf bat cava kvantum \
  | xargs -n1 | xargs -I{} git clone --depth 1 "${THEME_GIT_URL}/{}"

# https://github.com/catppuccin/gtk was archived, so download an alternative.
git clone --depth 1 https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme gtk

echo "Downloading Catppuccin cursor themes..."
for flavor in 'mocha' 'macchiato' 'frappe' 'latte'; do
  wget -P "${THEME_HOME}/cursors" \
    "${THEME_CURSORS_URL}/catppuccin-${flavor}-dark-cursors.zip"
done

echo "Unpacking Catppuccin cursor themes..."
sudo unzip -od /usr/share/icons/ "${THEME_HOME}/cursors/*.zip"

echo "Linking Alacritty Catppuccin themes..."
mkdir -p "${CONFIG_HOME}/alacritty/themes"
ln -sfvt "${CONFIG_HOME}/alacritty/themes" "${THEME_HOME}/alacritty"/*.toml

echo "Linking 'fzf' Catppuccin themes..."
mkdir -p "${CONFIG_HOME}/fzf/themes"
ln -sfvt "${CONFIG_HOME}/fzf/themes" "${THEME_HOME}/fzf/themes"/*.sh

echo "Linking 'bat' Catppuccin themes..."
mkdir -p "${CONFIG_HOME}/bat/themes"
ln -sfvt "${CONFIG_HOME}/bat/themes" "${THEME_HOME}/bat/themes"/*.tmTheme

echo "Linking 'cava' Catppuccin themes..."
mkdir -p "${CONFIG_HOME}/cava/themes"
ln -sfvt "${CONFIG_HOME}/cava/themes" "${THEME_HOME}/cava/themes"/*.cava

if command -v batcat &> /dev/null; then
  echo "Updating 'batcat' cache..."
  batcat cache --build
elif command -v bat &> /dev/null; then
  echo "Updating 'bat' cache..."
  bat cache --build
fi

echo "Installed Catppuccin successfully!"
