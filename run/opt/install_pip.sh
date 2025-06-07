#!/bin/bash -e
#
# Installs `pip`.
#
# See https://pip.pypa.io/en/stable/installation/.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies: `curl`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'pip'..."
curl -Lo - https://bootstrap.pypa.io/get-pip.py | python3
echo "Installed 'pip' successfully!"
