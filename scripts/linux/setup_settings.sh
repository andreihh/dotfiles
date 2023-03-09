#!/usr/bin/env bash

# Configures various system settings (keyboard layout, dark mode, etc.).

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Setting keyboard layout to US, with RO alternative..."
gsettings set org.gnome.desktop.input-sources sources \
  "[('xkb', 'us'), ('xkb', 'ro+std')]" \
  && echo "Keyboard layouts updated!" \
  || echoerr "Failed to update keyboard layouts!"

echo -e "\nSwapping Caps Lock and Esc keys..."
gsettings set org.gnome.desktop.input-sources xkb-options \
  "['caps:swapescape']" \
  && echo "Caps Lock and Esc keys swapped!" \
  || echoerr "Failed to swap Caps Lock and Esc keys!"

echo -e "\nRemoving Alt-Esc system key mapping..."
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "[]" \
  && echo "Alt-Esc key mapping removed!" \
  || echoerr "Failed to remove Alt-Esc key mapping!"

echo -e "\nSetting system theme to dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' \
  && echo "Dark mode enabled!" \
  || echoerr "Failed to set dark mode!"

echo -e "\nMaking hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop \
  && echo "All startup applications are visible!" \
  || echoerr "Failed to change visibility of hidden startup applications!"
