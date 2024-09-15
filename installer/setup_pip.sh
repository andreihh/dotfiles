#!/bin/bash

# Installs pip on the current system. Requires curl.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly INSTALLER="https://bootstrap.pypa.io/get-pip.py"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'pip'..."
curl -o- "$INSTALLER" | python3 \
  && echo "'pip' installed successfully!" \
  || echoerr "Failed to install 'pip'!"
