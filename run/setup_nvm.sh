#!/bin/bash -e
#
# Installs the latest LTS version of `nvm`.
#
# Requires `curl`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Downloading latest version of 'nvm'..."
PROFILE=/dev/null bash << EOF
curl -Lo - https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
EOF

echo "Loading 'nvm'..."
# shellcheck source=/dev/null
. "${XDG_CONFIG_HOME:-${HOME}/.config}/nvm/nvm.sh"

echo "Installing latest LTS version of 'nvm'..."
nvm install --lts

echo "Installed 'nvm' successfully!"
