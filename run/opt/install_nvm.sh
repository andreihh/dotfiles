#!/bin/bash -e
#
# Installs the latest LTS version of `nvm`.
#
# See https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies: `curl`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

echo "Downloading latest version of 'nvm'..."
PROFILE=/dev/null bash << EOF
curl -Lo - https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
EOF

echo "Loading 'nvm'..."
. "${XDG_CONFIG_HOME}/nvm/nvm.sh"

echo "Installing latest LTS version of 'nvm'..."
nvm install --lts

echo "Configuring 'nvm' shell integration..."
cat << 'EOF' > "${XDG_CONFIG_HOME}/bash.d/10-nvm_integration.sh"
# nvm_integration.sh: loads `nvm` shell integration.
#
# shellcheck shell=bash

[[ -s "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"
[[ -s "${NVM_DIR}/bash_completion" ]] && . "${NVM_DIR}/bash_completion"
EOF

echo "Installed 'nvm' successfully!"
