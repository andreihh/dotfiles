#!/bin/bash -e
#
# Installs Vim from sources for Linux systems.
#
# Requires `git`. Will install other dependencies.
#
# This is needed because the Vim version available in package managers is too
# old and doesn't support XDG directories (requires version 9.1.0327 or newer).

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly VIM_DIR="${HOME}/.local/src/vim"

echo "Installing Vim..."

echo "Installing Vim build dependencies..."
sudo apt install libncurses-dev

echo "Cleaning up prior Vim installation..."
rm -rf "${VIM_DIR}"

echo "Downloading Vim..."
mkdir -p "${VIM_DIR}"
git clone --depth 1 https://github.com/vim/vim "${VIM_DIR}"

echo "Running Vim installer..."
cd "${VIM_DIR}/src"
make
sudo make install

echo "Installed Vim successfully!"
