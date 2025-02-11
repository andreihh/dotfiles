#!/bin/bash -e
#
# Installs `pip`.
#
# Requires `curl`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'pip'..."
curl -Lo - https://bootstrap.pypa.io/get-pip.py | python3
echo "Installed 'pip' successfully!"
