#!/bin/sh
#
# Installs Ghostty.
#
# See https://ghostty.org/docs/install/binary.
#
# Supported systems: Debian*, Fedora*, MacOS
# Dependencies:
# - Debian*: `curl`
# - Fedora*: COPR
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

readonly DEB_INSTALLER='https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh'

echo "Installing Ghostty..."
has-cmd apt-get && /bin/bash -c "$(curl -fsSL "${DEB_INSTALLER}")"
has-cmd dnf && sudo dnf copr enable pgdev/ghostty && install-pkg ghostty
has-cmd brew && install-pkg ghostty

if has-cmd update-alternatives; then
  echo "Configuring Ghostty as the default terminal..."
  ghostty_bin="$(command -v ghostty)"
  sudo update-alternatives --install \
    /usr/bin/x-terminal-emulator \
    x-terminal-emulator \
    "${ghostty_bin}" 100
  sudo update-alternatives --set x-terminal-emulator "${ghostty_bin}"
fi

echo "Installed Ghostty successfully!"
