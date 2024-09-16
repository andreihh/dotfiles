#!/bin/bash

# Configures swappiness.

readonly SYSCTL_CONFIG="/etc/sysctl.conf"
readonly OPTION_PATTERN="#?vm.swappiness=.*"
readonly SED_REPLACE_OPTION_PATTERN="s/$OPTION_PATTERN/vm.swappiness=1/"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Setting swappiness to 1..."
if grep -Ex "$OPTION_PATTERN" "$SYSCTL_CONFIG"; then
  if sudo sed -i -E "$SED_REPLACE_OPTION_PATTERN" "$SYSCTL_CONFIG"; then
    echo "Swappiness updated to 1 successfully!"
  else
    echo "Failed to update swappiness to 1!"
    exit 1
  fi
else
  if echo "vm.swappiness=1" | sudo tee -a "$SYSCTL_CONFIG"; then
    echo "Swappiness set to 1 successfully!"
  else
    echo "Failed to set swappiness to 1!"
    exit 1
  fi
fi

echo "Reloading sysctl config..."
if sudo sysctl -p; then
  echo "Reloaded sysctl config!"
else
  echo "Failed to reload sysctl config!"
  exit 1
fi
