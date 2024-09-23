#!/bin/bash -e

# Configures custom key mappings:
# - Swaps CapsLock with Esc
# - Reorders bottom-left modifiers from (Ctrl, Super, Alt) to (Super, Alt, Ctrl)
# - Rebinds Super+[Shift]+Tab to Ctrl+[Shift]+Tab
# - Rebinds Ctrl+[Shift]+Tab to Alt+[Shift]+Tab

readonly KEYD_DIR="$HOME/.keyd"
readonly KEYD_CONFIG="$HOME/.dotfiles/linux/default.conf"
readonly KEYD_CONFIGS_DIR="/etc/keyd"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Cleaning up any prior 'keyd' installation..."
rm -rf "$KEYD_DIR/"

echo "Installing 'keyd'..."
git clone https://github.com/rvaiya/keyd "$KEYD_DIR"
cd "$KEYD_DIR"
make && sudo make install

echo "Setting up 'keyd' config..."
sudo mkdir -p "$KEYD_CONFIGS_DIR"
cat << EOF | sudo tee /etc/keyd/default.conf
[ids]
*

[main]
# Maps capslock to escape when pressed and control when held.
#capslock = overload(control, esc)

# Remaps the escape key to capslock
#esc = capslock

capslock = escape

leftalt = leftcontrol
leftcontrol = leftmeta
leftmeta = leftalt

[control]
tab = swapm(alt, tab)

[meta]
tab = C-tab

[meta+shift]
tab = C-S-tab
EOF

echo "Starting 'keyd'..."
sudo systemctl enable keyd
sudo systemctl start keyd

echo "Setup 'keyd' successfully!"
