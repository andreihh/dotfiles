#!/bin/bash -e
#
# Configures GNOME settings and dependencies.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

if ! command -v gnome-shell &> /dev/null; then
  echo "GNOME not installed, configuration skipped!"
  exit 0
fi

echo "Installing GNOME dependencies..."

command -v apt-get &> /dev/null && sudo apt-get install -y \
  gnome-shell-extension-user-theme \
  gnome-shell-extension-appindicator \
  gtk2-engines-murrine

command -v dnf &> /dev/null && sudo dnf install -y \
  gnome-shell-extension-user-theme \
  gnome-shell-extension-appindicator \
  gtk-murrine-engine

echo "Configuring GNOME settings..."
dconf load / << 'EOF'
[org/gnome/desktop/interface]
show-battery-percentage=true

[org/gnome/desktop/input-sources]
sources=[('xkb', 'us')]
xkb-options=['caps:swapescape', 'ctrl:swap_lalt_lctl_lwin']

[org/gnome/desktop/wm/keybindings]
move-to-workspace-1=['<Shift><Alt>1']
move-to-workspace-2=['<Shift><Alt>2']
move-to-workspace-3=['<Shift><Alt>3']
move-to-workspace-4=['<Shift><Alt>4']
switch-to-workspace-1=['<Alt>1']
switch-to-workspace-2=['<Alt>2']
switch-to-workspace-3=['<Alt>3']
switch-to-workspace-4=['<Alt>4']
switch-windows=['<Primary>Tab']
switch-windows-backward=['<Shift><Primary>Tab']
toggle-fullscreen=['<Shift><Primary>z']
toggle-maximized=['<Shift><Primary>m']

[org/gnome/mutter/keybindings]
toggle-tiled-left=['<Shift><Primary>h']
toggle-tiled-right=['<Shift><Primary>l']

[org/gnome/settings-daemon/plugins/media-keys]
custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sh/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmx/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sshc/']
home=['<Alt>e']
screensaver=['<Alt>Escape']
www=['<Alt>w']

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sh]
binding='<Alt>s'
command='x-terminal-emulator'
name='Launch shell terminal'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sshc]
binding='<Alt>c'
command='x-terminal-emulator -e sshc'
name='Launch sshc terminal'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmx]
binding='<Alt>x'
command='x-terminal-emulator -e tmx'
name='Launch tmx terminal'

[org/gnome/shell/keybindings]
focus-active-notification=['<Alt>n']
show-screen-recording-ui=['<Alt>r']
show-screenshot-ui=['<Alt>p']
toggle-overview=['<Alt>a']
EOF

echo "Configured GNOME successfully!"
