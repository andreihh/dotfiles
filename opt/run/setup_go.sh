#!/bin/bash -e
#
# Installs Go for Linux or MacOS systems.
#
# Requirements:
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Go..."

# Use Homebrew if available.
if command -v brew &> /dev/null; then
  brew install go
else
  sudo apt install -y golang-go
fi

echo "Installed Go successfully!"
