#!/bin/bash

# Configures device sleep modes.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly SLEEP_CONFIG="$DOTFILES_DIR/linux/sleep.conf"
readonly SLEEP_CONFIGS_DIR="/etc/systemd/sleep.conf.d"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Configuring device sleep modes..."
[[ -f "$SLEEP_CONFIG" ]] \
  && sudo mkdir -p "$SLEEP_CONFIGS_DIR" \
  && sudo ln -sfv "$SLEEP_CONFIG" "$SLEEP_CONFIGS_DIR/00-sleep.conf" \
  && echo "Device sleep modes configured successfully!" \
  || echoerr "Failed to configure device sleep modes!"
