#!/bin/bash -e
#
# Installs Ghostty for Linux systems.
#
# See https://github.com/mkasberg/ghostty-ubuntu.
#
# Requirements: `curl`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Ghostty..."
/bin/bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
echo "Installed Ghostty successfully!"
