#!/bin/sh
#
# Configures GNOME settings and dependencies.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

if ! has-cmd gnome-shell; then
  echo "GNOME not installed, configuration skipped!"
  exit 0
fi

echo "Installing GNOME dependencies..."
install-pkg \
  sassc \
  gnome-themes-extra \
  gnome-shell-extension-user-theme \
  gnome-shell-extension-system-monitor \
  gnome-shell-extension-appindicator

has-cmd apt-get && install-pkg gtk2-engines-murrine
has-cmd dnf && install-pkg gtk-murrine-engine
has-cmd rpm-ostree && install-pkg gtk-murrine-engine

echo "Configuring GNOME settings..."
dconf load / << 'EOF'
[org/gnome/desktop/interface]
clock-format='24h'
clock-show-date=true
clock-show-seconds=true
clock-show-weekday=true
enable-animations=false
show-battery-percentage=true

[org/gnome/desktop/input-sources]
sources=[('xkb', 'us')]
xkb-options=['caps:swapescape', 'ctrl:swap_lalt_lctl_lwin']

[org/gnome/desktop/wm/keybindings]
close=['<Primary>q']
cycle-windows=@as []
cycle-windows-backward=@as []
move-to-monitor-left=['<Primary><Alt>comma']
move-to-monitor-right=['<Primary><Alt>period']
move-to-workspace-1=['<Primary><Alt>1']
move-to-workspace-2=['<Primary><Alt>2']
move-to-workspace-3=['<Primary><Alt>3']
move-to-workspace-4=['<Primary><Alt>4']
switch-group=@as []
switch-group-backward=@as []
switch-to-workspace-1=['<Alt>1']
switch-to-workspace-2=['<Alt>2']
switch-to-workspace-3=['<Alt>3']
switch-to-workspace-4=['<Alt>4']
switch-windows=['<Primary>Tab']
switch-windows-backward=['<Shift><Primary>Tab']
toggle-fullscreen=['<Shift><Alt>z']
toggle-maximized=['<Alt>z']

[org/gnome/desktop/wm/preferences]
num-workspaces=4

[org/gnome/mutter]
dynamic-workspaces=false
workspaces-only-on-primary=false

[org/gnome/mutter/keybindings]
toggle-tiled-left=['<Primary><Alt>h']
toggle-tiled-right=['<Primary><Alt>l']

[org/gnome/settings-daemon/plugins/media-keys]
control-center=['<Shift><Alt>s']
custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sh/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmx/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sshc/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmxc/']
home=['<Alt>e']
logout=['<Shift><Alt>Escape']
mic-mute=['<Shift><Alt>BackSpace']
play=['<Alt>Return']
reboot=['<Alt>grave']
screen-brightness-down=['<Shift><Alt>minus']
screen-brightness-up=['<Shift><Alt>equal']
screensaver=['<Alt>Escape']
shutdown=['<Shift><Alt>grave']
volume-down=['<Alt>minus']
volume-mute=['<Alt>BackSpace']
volume-up=['<Alt>equal']
www=['<Alt>w']

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sh]
binding='<Alt>x'
command='x-terminal-emulator'
name='Launch terminal'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/sshc]
binding='<Alt>c'
command='x-terminal-emulator -e sshc'
name='Launch sshc terminal'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmx]
binding='<Shift><Alt>x'
command='x-terminal-emulator -e tmx'
name='Launch tmx terminal'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmxc]
binding='<Shift><Alt>c'
command='x-terminal-emulator -e tmxc'
name='Launch tmxc terminal'

[org/gnome/shell/extensions/system-monitor]
show-cpu=true
show-download=true
show-memory=true
show-swap=false
show-upload=false

[org/gnome/shell/keybindings]
focus-active-notification=['<Alt>n']
show-screen-recording-ui=['<Alt>r']
show-screenshot-ui=['<Alt>p']
toggle-message-tray=['<Shift><Alt>n']
toggle-overview=['<Alt>a']
EOF

echo "Enabling GNOME extensions..."
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable system-monitor@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable ubuntu-appindicators@ubuntu.com

echo "Configured GNOME successfully!"
echo "Run 'gnome-extensions list' and disable or uninstall unwanted extensions."
