#!/bin/bash -e
#
# Installs Rust for Linux or MacOS systems.
#
# Requirements: `curl`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'rustup'..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "Installed 'rustup' successfully!"
