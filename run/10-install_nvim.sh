#!/bin/bash -e
#
# Installs Neovim.
#
# See https://github.com/neovim/neovim/blob/master/BUILD.md.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - Linux: `git`, `unzip`, `curl`, `make`, `cmake`, `ninja-build`, `gettext`
# - Debian, Ubuntu: `build-essential`
# - Fedora, RHEL: `gcc`, `glibc-gconv-extra`
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Neovim..."

if command -v brew &> /dev/null; then
  # Install Neovim with Homebrew on MacOS and exit early.
  brew install nvim
  echo "Installed Neovim successfully!"
  exit 0
fi

echo "Creating temporary Neovim installation directory..."
NVIM_DIR="$(mktemp -d "${TMPDIR:-/tmp}/neovim.XXXXXXXXX")"
readonly NVIM_DIR

echo "Downloading Neovim stable branch..."
git clone -b stable --depth 1 https://github.com/neovim/neovim "${NVIM_DIR}"

echo "Running Neovim installer..."
cd "${NVIM_DIR}"
make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Cleaning up Neovim installation..."
rm -rf "${NVIM_DIR}"

echo "Configuring Neovim as the default editor..."
NVIM_BIN="$(command -v nvim)"
sudo update-alternatives --install /usr/bin/editor editor "${NVIM_BIN}" 100
sudo update-alternatives --set editor "${NVIM_BIN}"

echo "Installed Neovim successfully!"
