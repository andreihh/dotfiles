#!/bin/bash -e
#
# Installs `pyenv` for Linux or MacOS systems.
#
# Requirements:
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'pyenv'..."
if command -v brew &> /dev/null; then
  brew install pyenv
else
  curl -fsSL https://pyenv.run | bash
fi
echo "Installed 'pyenv' successfully!"
