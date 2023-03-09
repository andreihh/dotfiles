#!/usr/bin/env bash

# Configures TLP.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly TLP_CONFIG="$DOTFILES_DIR/linux/tlp.conf"
readonly TLP_CONFIGS_DIR="/etc/tlp.d"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Configuring TLP..."
[[ -d "$TLP_CONFIGS_DIR" && -f "$TLP_CONFIG" ]] \
  && sudo ln -sf "$TLP_CONFIG" "$TLP_CONFIGS_DIR/00-tlp.conf" \
  && sudo systemctl enable tlp.service \
  && sudo tlp start \
  && echo "TLP configured successfully!" \
  || echoerr "Failed to configure TLP!"
