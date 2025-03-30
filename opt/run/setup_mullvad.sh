#!/bin/bash -e
#
# Installs Mullvad Browser for Linux or MacOS systems.
#
# See https://mullvad.net/en/download/browser.
#
# Requirements:
# - Linux: `apt-get`
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Mullvad Browser..."

# Use Homebrew if available.
if command -v brew &> /dev/null; then
  brew install --cask mullvad-browser
else
  echo "Downloading the Mullvad signing key..."
  sudo curl -fsSLo \
    /usr/share/keyrings/mullvad-keyring.asc \
    https://repository.mullvad.net/deb/mullvad-keyring.asc

  echo "Adding the Mullvad repository server..."
  echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$(dpkg --print-architecture)] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/mullvad.list

  echo "Installing the Mullvad Browser package..."
  sudo apt-get update -y && sudo apt-get install -y mullvad-browser

  echo "Installing Mullvad Browser as browser alternative..."
  mullvad_browser_bin="$(command -v mullvad-browser)"
  sudo update-alternatives --install \
    /usr/bin/x-www-browser x-www-browser \
    "${mullvad_browser_bin}" 50
fi

echo "Installed Mullvad Browser successfully!"
