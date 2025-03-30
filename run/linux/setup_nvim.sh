#!/bin/bash -e
#
# Installs Neovim from sources for Linux systems.
#
# Requirements: `apt-get`, `git`, `make`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly NVIM_DIR="${HOME}/.local/src/nvim"

echo "Installing Neovim..."

echo "Installing Neovim build dependencies..."
sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential

echo "Cleaning up prior Neovim installation..."
rm -rf "${NVIM_DIR}"
sudo rm -f /usr/local/bin/nvim
sudo rm -rf /usr/local/share/nvim/

echo "Downloading Neovim stable branch..."
mkdir -p "${NVIM_DIR}"
git clone -b stable --depth 1 https://github.com/neovim/neovim "${NVIM_DIR}"

echo "Running Neovim installer..."
cd "${NVIM_DIR}"
make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Installed Neovim successfully!"
