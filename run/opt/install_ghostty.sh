#!/bin/bash -e
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

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly DEB_INSTALLER='https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh'

echo "Installing Ghostty..."

command -v apt-get &> /dev/null \
  && /bin/bash -c "$(curl -fsSL "${DEB_INSTALLER}")"

command -v dnf &> /dev/null \
  && sudo dnf copr enable pgdev/ghostty && sudo dnf install -y ghostty

command -v brew &> /dev/null && brew install --cask ghostty

if command -v update-alternatives; then
  echo "Configuring Ghostty as the default terminal..."
  GHOSTTY_BIN="$(command -v ghostty)"
  sudo update-alternatives --install \
    /usr/bin/x-terminal-emulator \
    x-terminal-emulator \
    "${GHOSTTY_BIN}" 100
  sudo update-alternatives --set x-terminal-emulator "${GHOSTTY_BIN}"
fi

echo "Installed Ghostty successfully!"
