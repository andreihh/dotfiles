#!/bin/sh
#
# Installs Ghostty.
#
# See https://ghostty.org/docs/install/binary.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - Debian, Ubuntu: `curl`
# - Fedora, RHEL: COPR
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

readonly DEB_INSTALLER='https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh'

echo "Installing Ghostty..."

command -v apt-get > /dev/null 2>&1 \
  && /bin/bash -c "$(curl -fsSL "${DEB_INSTALLER}")"

command -v dnf > /dev/null 2>&1 \
  && sudo dnf copr enable pgdev/ghostty && sudo dnf install -y ghostty

command -v brew > /dev/null 2>&1 && brew install ghostty

if command -v update-alternatives > /dev/null 2>&1; then
  echo "Configuring Ghostty as the default terminal..."
  ghostty_bin="$(command -v ghostty)"
  sudo update-alternatives --install \
    /usr/bin/x-terminal-emulator \
    x-terminal-emulator \
    "${ghostty_bin}" 100
  sudo update-alternatives --set x-terminal-emulator "${ghostty_bin}"
fi

echo "Installed Ghostty successfully!"
