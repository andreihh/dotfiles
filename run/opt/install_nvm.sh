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
readonly NVM_DIR="${NVM_DIR:-${XDG_CONFIG_HOME}/nvm}"

echo "Downloading latest version of 'nvm' to '${NVM_DIR}'..."
PROFILE=/dev/null bash << EOF
curl -Lo - https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
EOF

echo "Loading 'nvm'..."
. "${NVM_DIR}/nvm.sh"

echo "Installing latest LTS version of Node.js..."
nvm install --lts

echo "Configuring 'nvm' shell integration..."
cat << 'EOF' > "${XDG_CONFIG_HOME}/bash.d/20-nvm_integration.sh"
# nvm_integration.sh: loads `nvm` shell integration.
#
# shellcheck shell=bash

[[ -s "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"
[[ -s "${NVM_DIR}/bash_completion" ]] && . "${NVM_DIR}/bash_completion"
EOF

echo "Installed 'nvm' successfully!"
