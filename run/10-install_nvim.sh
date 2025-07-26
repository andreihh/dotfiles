#!/bin/sh
#
# Installs Neovim from sources.
#
# See https://github.com/neovim/neovim/blob/master/BUILD.md.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

case "$(uname -s)" in
  Darwin)
    echo "MacOS not supported, Neovim installation from sources skipped!"
    exit 0
    ;;
  *) ;;
esac

echo "Installing Neovim from sources..."

echo "Installing Neovim build dependencies..."
install-pkg git curl make cmake ninja-build gettext
has-cmd apt-get && install-pkg build-essential
has-cmd dnf && install-pkg gcc glibc-gconv-extra
has-cmd rpm-ostree && install-pkg gcc glibc-gconv-extra

echo "Creating temporary Neovim installation directory..."
nvim_dir="$(mktemp -d "${TMPDIR:-/tmp}/neovim.XXXXXXXXX")"

echo "Downloading Neovim stable branch..."
git clone -b stable --depth 1 https://github.com/neovim/neovim "${nvim_dir}"

echo "Building Neovim binary..."
cd "${nvim_dir}"
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="'${HOME}/.local'"

echo "Installing Neovim binary to '${HOME}/.local/bin'..."
make install

echo "Configuring Neovim as the default editor..."
nvim_bin="$(command -v nvim)"
sudo update-alternatives --install /usr/bin/editor editor "${nvim_bin}" 100
sudo update-alternatives --set editor "${nvim_bin}"

echo "Installed Neovim successfully!"
