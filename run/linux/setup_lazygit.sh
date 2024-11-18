#!/bin/bash -e
#
# Installs Lazygit from sources for Linux systems.
#
# Requires `curl`, `tar` and `install`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly LAZYGIT_DIR="${HOME}/.local/src/lazygit"

echo "Installing Lazygit..."

echo "Cleaning up prior Lazygit installation..."
rm -rf "${LAZYGIT_DIR}"
rm -f "${HOME}/.local/bin/lazygit"

echo "Retrieving latest Lazygit version..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')

echo "Setting up download directory..."
mkdir -p "${LAZYGIT_DIR}"
cd "${LAZYGIT_DIR}"

echo "Downloading Lazygit..."
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

echo "Extracting Lazygit binary..."
tar xf lazygit.tar.gz lazygit
rm lazygit.tar.gz

echo "Installing Lazygit binary..."
sudo install lazygit -D -t "${HOME}/.local/bin/"

echo "Installed Lazygit successfully!"
