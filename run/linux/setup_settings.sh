#!/bin/bash -e
#
# Configures various system settings (keyboard layout, dark mode, etc.).

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly GNOME_KEYBINDINGS="org.gnome.desktop.wm.keybindings"
readonly MUTTER_KEYBINDINGS="org.gnome.mutter.keybindings"
readonly SHELL_KEYBINDINGS="org.gnome.shell.keybindings"
readonly GNOME_MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
readonly NEW_SHELL_KEY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
readonly NEW_TMX_KEY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"

echo "Updating system settings..."

echo "Setting system theme to dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "Setting keyboard layout to US..."
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"

echo "Swapping Caps Lock with Esc and reordering modifiers to Super|Alt|Ctrl..."
gsettings set org.gnome.desktop.input-sources xkb-options \
  "['caps:swapescape', 'ctrl:swap_lalt_lctl_lwin']"

echo "Setting switch windows shortcuts to Ctrl-[Shift]-Tab..."
gsettings set "${GNOME_KEYBINDINGS}" switch-windows "['<Primary>Tab']"
gsettings set "${GNOME_KEYBINDINGS}" switch-windows-backward \
  "['<Shift><Primary>Tab']"

echo "Setting toggle tiled left shortcut to Ctrl-Alt-comma..."
gsettings set "${MUTTER_KEYBINDINGS}" toggle-tiled-left \
  "['<Primary><Alt>comma']"

echo "Setting toggle tiled right shortcut to Ctrl-Alt-period..."
gsettings set "${MUTTER_KEYBINDINGS}" toggle-tiled-right \
  "['<Primary><Alt>period']"

echo "Setting toggle maximized shortcut to Ctrl-Alt-m..."
gsettings set "${GNOME_KEYBINDINGS}" toggle-maximized "['<Primary><Alt>m']"

echo "Setting toggle fullscreen shortcut to Ctrl-Alt-f..."
gsettings set "${GNOME_KEYBINDINGS}" toggle-fullscreen "['<Primary><Alt>f']"

echo "Setting print screen shortcut to Ctrl-Alt-p..."
gsettings set "${SHELL_KEYBINDINGS}" show-screenshot-ui "['<Primary><Alt>p']"

echo "Setting lock screen shortcut to Ctrl-Alt-l..."
gsettings set "${GNOME_MEDIA_KEYS}" screensaver "['<Primary><Alt>l']"

echo "Setting new file explorer shortcut to Ctrl-Alt-e..."
gsettings set "${GNOME_MEDIA_KEYS}" home "['<Primary><Alt>e']"

echo "Setting new web browser shortcut to Ctrl-Alt-w..."
gsettings set "${GNOME_MEDIA_KEYS}" www "['<Primary><Alt>w']"

echo "Setting custom shortcuts..."
gsettings set "${GNOME_MEDIA_KEYS}" custom-keybindings \
  "['${NEW_SHELL_KEY}', '${NEW_TMX_KEY}']"

echo "Setting new shell terminal shortcut to Ctrl-Alt-s..."
gsettings set "${GNOME_MEDIA_KEYS}.custom-keybinding:${NEW_SHELL_KEY}" \
  name 'Launch shell terminal'
gsettings set "${GNOME_MEDIA_KEYS}.custom-keybinding:${NEW_SHELL_KEY}" \
  command 'x-terminal-emulator'
gsettings set "${GNOME_MEDIA_KEYS}.custom-keybinding:${NEW_SHELL_KEY}" \
  binding '<Primary><Alt>s'

echo "Setting new 'tmx' terminal shortcut to Ctrl-Alt-x..."
gsettings set "${GNOME_MEDIA_KEYS}.custom-keybinding:${NEW_TMX_KEY}" \
  name 'Launch tmx terminal'
gsettings set "${GNOME_MEDIA_KEYS}.custom-keybinding:${NEW_TMX_KEY}" \
  command 'x-terminal-emulator -e tmx'
gsettings set "${GNOME_MEDIA_KEYS}.custom-keybinding:${NEW_TMX_KEY}" \
  binding '<Primary><Alt>x'

echo "Setting up default web browser interactively..."
sudo update-alternatives --config x-www-browser

for term in 'ghostty' 'alacritty'; do
  term_bin="$(command -v "${term}")" || true
  [[ -f "${term_bin}" ]] \
    && echo "Installing '${term}' as terminal alternative..." \
    && sudo update-alternatives --install \
      /usr/bin/x-terminal-emulator x-terminal-emulator \
      "${term_bin}" 50
done

echo "Setting up default terminal interactively..."
sudo update-alternatives --config x-terminal-emulator

echo "Setting up Neovim as default editor..."
NVIM="$(command -v nvim)"
readonly NVIM
if [[ -f "${NVIM}" ]]; then
  sudo update-alternatives --install /usr/bin/editor editor "${NVIM}" 100
  sudo update-alternatives --set editor "${NVIM}"
else
  echo "Did not find Neovim! Setting up default editor interactively..."
  sudo update-alternatives --config editor
fi

echo "Changing default shell to Bash..."
[[ -n "${debug}" ]] || chsh -s '/bin/bash'

echo "Making hidden startup applications visible..."
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop

echo "System settings updated!"
