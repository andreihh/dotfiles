#!/bin/bash

# Configures swappiness.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly SYSCTL_CONFIG="/etc/sysctl.conf"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Setting swappiness to 1..."
if grep -Ex "#?vm.swappiness=.*" "$SYSCTL_CONFIG"; then
  sudo sed -i -E "s/#?vm.swappiness=.*/vm.swappiness=1/" "$SYSCTL_CONFIG" \
    && sudo sysctl -p \
    && echo "Swappiness updated to 1 successfully!" \
    || echoerr "Failed to update swappiness to 1!"
else
  echo "vm.swappiness=1" | sudo tee -a "$SYSCTL_CONFIG" \
    && sudo sysctl -p \
    && echo "Swappiness set to 1 successfully!" \
    || echoerr "Failed to set swappiness to 1!"
fi
