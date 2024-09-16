#!/bin/bash

# Installs the latest LTS version of nvm on the current system.
#
# Requires `curl`.

readonly INSTALLER=\
"https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing latest LTS version of 'nvm'..."
PROFILE=~/.exports bash -c "curl -o- $INSTALLER | bash"
if nvm install --lts; then
  echo "'nvm' installed successfully!"
else
  echo "Failed to install 'nvm'!"
  exit 1
fi
