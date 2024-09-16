#!/bin/bash

# Installs IntelliJ IDEA CE for Linux systems.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing IntelliJ IDEA CE..."
sudo apt-get install snapd && sudo snap refresh
if sudo snap install intellij-idea-community --classic; then
  echo "Installed IntelliJ IDEA CE successfully!"
else
  echo "Failed to install IntelliJ IDEA CE!"
  exit 1
fi
