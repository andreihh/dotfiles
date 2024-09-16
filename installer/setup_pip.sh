#!/bin/bash

# Installs pip on the current system.
#
# Requires `curl`.

readonly INSTALLER="https://bootstrap.pypa.io/get-pip.py"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'pip'..."
if curl -o- "$INSTALLER" | python3; then
  echo "'pip' installed successfully!"
else
  echo "Failed to install 'pip'!"
  exit 1
fi
