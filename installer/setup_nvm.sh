#!/bin/bash -e

# Installs the latest LTS version of `nvm`.
#
# Requires `curl`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing latest LTS version of 'nvm'..."
curl -Lo - https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh \
  | bash
. "${XDG_CONFIG_HOME:-${HOME}/.config}/nvm/nvm.sh"
nvm install --lts
echo "Installed 'nvm' successfully!"
