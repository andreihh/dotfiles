#!/bin/bash -e

# Configures various system settings (keyboard layout, dark mode, etc.).

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly GNOME_KEYBINDINGS="org.gnome.desktop.wm.keybindings"
readonly GNOME_MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
readonly NEW_TMUX_KEY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"

echo "Updating system settings..."

echo "Setting keyboard layout to US..."
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"

echo "Swapping Caps Lock with Esc and reordering modifiers to Super|Alt|Ctrl..."
gsettings set org.gnome.desktop.input-sources xkb-options \
  "['caps:swapescape', 'ctrl:swap_lalt_lctl_lwin']"

echo "Removing Alt-Esc system key mapping..."
gsettings set "$GNOME_KEYBINDINGS" cycle-windows "[]"

echo "Setting switch windows shortcuts to Ctrl-[Shift]-Tab..."
gsettings set "$GNOME_KEYBINDINGS" switch-windows "['<Primary>Tab']"
gsettings set "$GNOME_KEYBINDINGS" switch-windows-backward \
  "['<Shift><Primary>Tab']"

echo "Setting toggle maximized shortcut to Ctrl-Alt-m..."
gsettings set "$GNOME_KEYBINDINGS" toggle-maximized "['<Primary><Alt>m']"

echo "Setting lock screen shortcut to Ctrl-Alt-l..."
gsettings set "$GNOME_MEDIA_KEYS" screensaver "['<Primary><Alt>l']"

echo "Setting up 'uxterm' as default terminal..."
if [ -f /usr/bin/uxterm ]; then
  sudo update-alternatives --set x-terminal-emulator /usr/bin/uxterm
fi

echo "Setting new shell terminal shortcut to Ctrl-Alt-s..."
gsettings set "$GNOME_MEDIA_KEYS" terminal "['<Primary><Alt>s']"

echo "Setting new Tmux terminal shortcut to Ctrl-Alt-w..."
gsettings set "$GNOME_MEDIA_KEYS" custom-keybindings "['$NEW_TMUX_KEY']"
gsettings set "$GNOME_MEDIA_KEYS.custom-keybinding:$NEW_TMUX_KEY" \
  name "'Launch tmuxw in terminal'"
gsettings set "$GNOME_MEDIA_KEYS.custom-keybinding:$NEW_TMUX_KEY" \
  command "\"x-terminal-emulator -e 'tmux new -A -s work'\""
gsettings set "$GNOME_MEDIA_KEYS.custom-keybinding:$NEW_TMUX_KEY" \
  binding "'<Primary><Alt>w'"

echo "Setting system theme to dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "Making hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop

echo "System settings updated!"
