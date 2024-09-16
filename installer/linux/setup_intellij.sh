#!/bin/bash

# Installs IntelliJ IDEA CE for Linux systems.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing IntelliJ IDEA CE..."
sudo apt-get install snapd \
  && sudo snap refresh \
  && sudo snap install intellij-idea-community --classic \
  && echo "Installed IntelliJ IDEA CE successfully!" \
  || echoerr "Failed to install IntelliJ IDEA CE!"
