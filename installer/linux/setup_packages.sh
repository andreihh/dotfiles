#!/bin/bash

# Installs various packages specific for Linux systems.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1
. "$HOME/.dotfiles/scripts/package_index.sh" || exit 1

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating package index..."
sudo apt-get update || echoerr "Failed to update package index!"

echo "Installing required packages..."
install_packages "sudo apt-get -y install" $LINUX_PACKAGES

echo "Packages installed!"
