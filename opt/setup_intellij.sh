#!/bin/bash -e
#
# Installs IntelliJ IDEA CE for Linux or MacOS systems.
#
# Requires Homebrew on MacOS.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing IntelliJ IDEA CE..."

# Use Homebrew if Available.
command -v brew &> /dev/null \
  && brew install --cask intellij-idea-ce \
  && echo "Installed IntelliJ IDEA CE successfully!" \
  && exit 0

echo "Installing Snap..."
sudo apt install snapd

echo "Refreshing Snap packages..."
sudo snap refresh

echo "Installing IntelliJ IDEA CE Snap package..."
sudo snap install intellij-idea-community --classic
echo "Installed IntelliJ IDEA CE successfully!"
