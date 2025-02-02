#!/bin/bash -e
#
# Configures swappiness.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly SYSCTL_CONFIG="/etc/sysctl.conf"
readonly OPTION_PATTERN='#?vm.swappiness=.*'
readonly SED_REPLACE_OPTION_PATTERN="s/${OPTION_PATTERN}/vm.swappiness=1/"

echo "Setting swappiness to 1..."
if grep -Ex "${OPTION_PATTERN}" "${SYSCTL_CONFIG}"; then
  sudo sed -i -E "${SED_REPLACE_OPTION_PATTERN}" "${SYSCTL_CONFIG}"
else
  echo "vm.swappiness=1" | sudo tee -a "${SYSCTL_CONFIG}"
fi

echo "Reloading sysctl config..."
sudo sysctl -p

echo "Swappiness updated to 1 successfully!"
