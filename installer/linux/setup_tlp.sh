#!/bin/bash

# Configures TLP.

readonly TLP_CONFIG="$HOME/.dotfiles/linux/tlp.conf"
readonly TLP_CONFIGS_DIR="/etc/tlp.d"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Configuring TLP..."

if [[ ! -f "$TLP_CONFIG" ]]; then
  echo "TLP config '$TLP_CONFIG' does not exist!"
  exit 1
fi

if [[ ! -d "$TLP_CONFIGS_DIR" ]]; then
  echo "TLP configs directory '$TLP_CONFIGS_DIR' does not exist!"
  exit 1
fi

echo "Setting up TLP config..."
if sudo ln -sfv "$TLP_CONFIG" "$TLP_CONFIGS_DIR/00-tlp.conf"; then
  echo "Starting up TLP service..."
  if sudo systemctl enable tlp.service && sudo tlp start; then
    echo "Configured TLP successfully!"
  else
    echo "Failed to start up TLP service!"
    exit 1
  fi
else
  echo "Failed to set up TLP config!"
  exit 1
fi
