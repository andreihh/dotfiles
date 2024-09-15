#!/bin/bash

# Installs the latest LTS version of nvm on the current system. Requires curl.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly INSTALLER=\
"https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing latest LTS version of 'nvm'..."
PROFILE=~/.exports bash -c "curl -o- $INSTALLER | bash" \
  && nvm install --lts \
  && echo "'nvm' installed successfully!" \
  || echoerr "Failed to install 'nvm'!"
