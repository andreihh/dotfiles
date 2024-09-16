#!/bin/bash -e

# Installs IntelliJ IDEA CE for Linux systems.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'snapd'..."
sudo apt-get install snapd

echo "Refreshing snap packages..."
sudo snap refresh

echo "Installing IntelliJ IDEA CE..."
sudo snap install intellij-idea-community --classic
echo "Installed IntelliJ IDEA CE successfully!"
