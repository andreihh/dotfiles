#!/bin/sh
#
# Installs `pip`.
#
# See https://pip.pypa.io/en/stable/installation/.
#
# Dependencies: `curl`, `python3`

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

echo "Installing 'pip'..."
curl -Lo - https://bootstrap.pypa.io/get-pip.py | python3

echo "Installed 'pip' successfully!"
