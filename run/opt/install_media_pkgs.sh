#!/bin/sh
#
# Installs media packages.
#
# Supported systems: Debian*, Fedora*, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

echo "Installing media packages..."
install-pkg restic rclone keepassxc vlc
echo "Installed media packages successfully!"
