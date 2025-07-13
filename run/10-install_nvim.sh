#!/bin/sh
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

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

echo "Installing Neovim..."

if command -v brew > /dev/null 2>&1; then
  # Install Neovim with Homebrew on MacOS and exit early.
  brew install nvim
  echo "Installed Neovim successfully!"
  exit 0
fi

echo "Creating temporary Neovim installation directory..."
nvim_dir="$(mktemp -d "${TMPDIR:-/tmp}/neovim.XXXXXXXXX")"

echo "Downloading Neovim stable branch..."
git clone -b stable --depth 1 https://github.com/neovim/neovim "${nvim_dir}"

echo "Running Neovim installer..."
cd "${nvim_dir}"
make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Configuring Neovim as the default editor..."
nvim_bin="$(command -v nvim)"
sudo update-alternatives --install /usr/bin/editor editor "${nvim_bin}" 100
sudo update-alternatives --set editor "${nvim_bin}"

echo "Installed Neovim successfully!"
