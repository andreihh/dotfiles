#!/bin/bash -e

# Configures various system settings (keyboard layout, dark mode, etc.).

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating system settings..."

echo "Setting keyboard layout to US..."
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"

echo "Removing Alt-Esc system key mapping..."
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "[]"

#echo "Swapping Caps Lock with Esc and reordering bottom-left modifier keys..."
#gsettings set org.gnome.desktop.input-sources xkb-options \
#  "['caps:swapescape', 'ctrl:swap_lalt_lctl_lwin']"

#echo "Setting switch applications shortcut to Ctrl-[Shift]-Tab..."
#gsettings set org.gnome.desktop.wm.keybindings switch-applications \
#  "['<Control>Tab']"
#gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward \
#  "['<Shift><Control>Tab']"

#echo "Setting switch windows shortcut to Super-[Shift]-Tab..."
#gsettings set org.gnome.desktop.wm.keybindings switch-windows \
#  "['<Super>Tab']"
#gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward \
#  "['<Shift><Super>Tab']"

echo "Setting system theme to dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "Making hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop

echo "System settings updated!"
