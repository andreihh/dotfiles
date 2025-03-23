#!/bin/bash -e
#
# Installs IntelliJ IDEA CE for Linux or MacOS systems.
#
# Requirements:
# - Linux: Snap, Java
# - MacOS: Homebrew, Java

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing IntelliJ IDEA CE..."

# Use Homebrew if available.
if command -v brew &> /dev/null; then
  brew install --cask intellij-idea-ce
else
  snap install intellij-idea-community --classic
fi
