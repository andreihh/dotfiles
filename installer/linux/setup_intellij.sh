#!/bin/bash -e
#
# Installs IntelliJ IDEA CE for Linux systems.
#
# Requires `snapd`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Snap..."
sudo apt install snapd

echo "Refreshing Snap packages..."
sudo snap refresh

echo "Installing IntelliJ IDEA CE..."
sudo snap install intellij-idea-community --classic
echo "Installed IntelliJ IDEA CE successfully!"
