#!/bin/bash -e

# Installs `pip`.
#
# Requires `curl`.

readonly INSTALLER="https://bootstrap.pypa.io/get-pip.py"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing pip..."
curl -o- "$INSTALLER" | python3
echo "Installed pip successfully!"
