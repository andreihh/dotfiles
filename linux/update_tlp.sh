#!/usr/bin/env bash

# This script will update the TLP config and apply the changes.

readonly TLP_CONFIG="/etc/tlp.conf"
readonly USER_TLP_CONFIG="$HOME/.tlp.conf"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

[[ -f "$TLP_CONFIG" && -f "$USER_TLP_CONFIG" ]] \
  && sudo sed -i '/# ~/\.tlp\.conf:.*/,$d' "$TLP_CONFIG" \
  && cat "$USER_TLP_CONFIG" | sudo tee -a "$TLP_CONFIG" \
  && sudo systemctl enable tlp.service \
  && sudo tlp start
