#!/bin/bash -e
#
# Installs Ghostty for Linux systems.
#
# Requires `curl`. See https://github.com/mkasberg/ghostty-ubuntu.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Ghostty..."

source /etc/os-release

echo "Installing Ghostty dependencies..."
sudo apt install -y libonig5

echo "Checking latest Ghostty release..."
GHOSTTY_DEB_URL=$(
   curl -s https://api.github.com/repos/mkasberg/ghostty-ubuntu/releases/latest | \
   grep -oP "https://github.com/mkasberg/ghostty-ubuntu/releases/download/[^\s/]+/ghostty_[^\s/_]+_amd64_${VERSION_ID}.deb"
)
GHOSTTY_DEB_FILE=$(basename "${GHOSTTY_DEB_URL}")

echo "Downloading Ghostty..."
curl -LO "${GHOSTTY_DEB_URL}"

echo "Installing Ghostty package..."
sudo dpkg -i "${GHOSTTY_DEB_FILE}"

echo "Cleaning up Ghostty package..."
rm "${GHOSTTY_DEB_FILE}"

echo "Installed Ghostty successfully!"
