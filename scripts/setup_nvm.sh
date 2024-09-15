#!/bin/bash

# Installs the latest LTS version of NVM on the current system.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly INSTALLER=\
"https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing latest LTS version of NVM..."
PROFILE=~/.exports bash -c "curl -o- $INSTALLER | bash" \
  && nvm install --lts \
  && "NVM installed successfully!" \
  || echoerr "Failed to install NVM!"
