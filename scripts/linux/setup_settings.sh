#!/usr/bin/env bash

# Configures various system settings (keyboard layout, dark mode, etc.).

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating system settings..."

echo "Setting keyboard layout to US, with RO alternative..."
gsettings set org.gnome.desktop.input-sources sources \
  "[('xkb', 'us'), ('xkb', 'ro+std')]" \
  || echoerr "Failed to update keyboard layouts!"

echo "Swapping Caps Lock and Esc keys..."
gsettings set org.gnome.desktop.input-sources xkb-options \
  "['caps:swapescape']" \
  || echoerr "Failed to swap Caps Lock and Esc keys!"

echo "Removing Alt-Esc system key mapping..."
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "[]" \
  || echoerr "Failed to remove Alt-Esc key mapping!"

echo "Setting system theme to dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' \
  || echoerr "Failed to set dark mode!"

echo "Making hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop \
  || echoerr "Failed to change visibility of hidden startup applications!"

echo "System settings updated!"
