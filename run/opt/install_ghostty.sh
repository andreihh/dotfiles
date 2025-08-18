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

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly DEB_INSTALLER='https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh'

echo "Installing Ghostty..."
has-cmd apt-get && /bin/bash -c "$(curl -fsSL "${DEB_INSTALLER}")"
has-cmd dnf && sudo dnf copr enable pgdev/ghostty && install-pkg ghostty
has-cmd brew && install-pkg ghostty

echo "Configuring Ghostty as the default XDG terminal..."
rm "${XDG_CONFIG_HOME}"/*-xdg-terminals.list
echo 'com.mitchellh.ghostty.desktop' > "${XDG_CONFIG_HOME}/xdg-terminals.list"

echo "Installed Ghostty successfully!"
