#!/bin/bash

# Installs dotfiles.
#
# Supports Linux and MacOS. Requires `curl`.

readonly GH_ROOT=\
"https://raw.githubusercontent.com/andreihh/.dotfiles/master/installer"
readonly INSTALLER_DIR="$HOME/.dotfiles/installer"
readonly INSTALLER="install.sh"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

shopt -s nocasematch
case "$OSTYPE" in
  linux*) platform="linux" ;;
  darwin*) platform="macos" ;;
  *) echo "Platform '$OSTYPE' not supported!"; exit 1 ;;
esac
shopt -u nocasematch

package_index="$INSTALLER_DIR/$platform/package_index.txt"
setup_scripts=$(echo "$INSTALLER_DIR"{,/linux}/setup_*.sh)

echo "Downloading installer..."
curl -LO "$GH_ROOT/$INSTALLER" || exit 1

echo "Running installer..."
chmod +x "$INSTALLER" \
  && ./"$INSTALLER" "$platform" "$package_index" $setup_scripts \
  && rm "$INSTALLER" \
  || exit 1
