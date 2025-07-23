#!/bin/sh
#
# Installs media packages.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

echo "Installing media packages..."
install-pkg xdg-user-dirs rclone vlc cava
has-cmd apt-get && install-pkg cmus
has-cmd brew && install-pkg cmus

echo "Media setup complete!"
