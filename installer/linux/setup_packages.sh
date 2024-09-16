#!/bin/bash

# Installs various packages specific for Linux systems.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1
. "$HOME/.dotfiles/scripts/package_index.sh" || exit 1

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating package index..."
sudo apt-get update || echoerr "Failed to update package index!"

echo "Installing required packages..."
install_packages "sudo apt-get -y install" $LINUX_PACKAGES

echo "Updating Snap packages..."
sudo snap refresh || echoerr "Failed to update Snap packages!"

echo "Installing Snap packages..."
install packages "sudo snap install" intellij-idea-community --classic

# See headless installation instructions on https://dropbox.com/install-linux.
echo "Installing Dropbox..."
readonly DROPBOX="https://www.dropbox.com/download?plat=lnx.x86_64"
cd ~ && wget -O - "$DROPBOX" | tar xzf - \
  && ~/.dropbox-dist/dropboxd \
  || echoerr "Failed to install Dropbox!"

echo "Packages installed!"
