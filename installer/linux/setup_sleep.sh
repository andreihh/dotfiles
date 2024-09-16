#!/bin/bash

# Configures device sleep modes.

readonly SLEEP_CONFIG="$HOME/.dotfiles/linux/sleep.conf"
readonly SLEEP_CONFIGS_DIR="/etc/systemd/sleep.conf.d"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Configuring device sleep modes..."

if [[ ! -f "$SLEEP_CONFIG" ]]; then
  echo "Sleep config '$SLEEP_CONFIG' does not exist!"
  exit 1
fi

sudo mkdir -p "$SLEEP_CONFIGS_DIR"
if sudo ln -sfv "$SLEEP_CONFIG" "$SLEEP_CONFIGS_DIR/00-sleep.conf"; then
  echo "Configured device sleep modes successfully!"
else
  echo "Failed to configure device sleep modes!"
  exit 1
fi
