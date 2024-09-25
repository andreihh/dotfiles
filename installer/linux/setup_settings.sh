#!/bin/bash -e

# Configures various system settings (keyboard layout, dark mode, etc.).

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly GNOME_MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
readonly NEW_TMUX_KEY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
readonly NEW_TMUX_COMMAND="gnome-terminal --window --maximize -- /bin/bash -c 'tmux new -A -s work'"
readonly TERMINAL_KEYBINDINGS="org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/"
readonly TERMINAL_DISABLED_COMMANDS="copy zoom-in zoom-out new-window new-tab close-tab"

echo "Updating system settings..."

echo "Setting keyboard layout to US..."
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"

echo "Removing Alt-Esc system key mapping..."
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "[]"

echo "Enforce Alt-[Shift]-Tab shortcuts to switch windows..."
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward \
  "['<Shift><Alt>Tab']"

echo "Swapping Caps Lock with Esc and reordering modifiers [Super Alt Ctrl]..."
gsettings set org.gnome.desktop.input-sources xkb-options \
  "['caps:swapescape', 'ctrl:swap_lalt_lctl_lwin']"

echo "Setting lock screen shortcut to Ctrl-Alt-l..."
gsettings set "$GNOME_MEDIA_KEYS" screensaver "['<Primary><Alt>l']"

echo "Setting new terminal shortcut to Ctrl-Alt-s..."
gsettings set "$GNOME_MEDIA_KEYS" terminal \
  "['<Primary><Alt>s']"

echo "Setting new Tmux terminal shortcut to Ctrl-Alt-w..."
gsettings set "$GNOME_MEDIA_KEYS" custom-keybindings "['$NEW_TMUX_KEY']"
gsettings set "$GNOME_MEDIA_KEYS.custom-keybinding:$NEW_TMUX_KEY" \
  name "'Launch tmuxw in Gnome terminal'"
gsettings set "$GNOME_MEDIA_KEYS.custom-keybinding:$NEW_TMUX_KEY" \
  command "\"$NEW_TMUX_COMMAND\""
gsettings set "$GNOME_MEDIA_KEYS.custom-keybinding:$NEW_TMUX_KEY" \
  binding "'<Primary><Alt>w'"

echo "Setting up terminal shortcuts..."
gsettings set "$TERMINAL_KEYBINDINGS" paste "'<Alt>p'"
gsettings set "$TERMINAL_KEYBINDINGS" close-window "'<Primary>q'"
for cmd in $TERMINAL_DISABLED_COMMANDS; do
  gsettings set "$TERMINAL_KEYBINDINGS" "$cmd" "'disabled'"
done
for i in {1..10}; do
  gsettings set "$TERMINAL_KEYBINDINGS" "switch-to-tab-$i" "'disabled'"
done

echo "Setting system theme to dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "Making hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop

echo "System settings updated!"
