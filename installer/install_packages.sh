#!/bin/bash

# Installs specified packages for the specified system ('linux' or 'macos').
#
# The package index file must delimit packages by ';'. Prepend any required
# special arguments for the installer to the package name (e.g., '--cask').
#
# Requires `apt` on Linux and `curl` on MacOS.

[[ $# -ne 2 ]] && echo "Usage: $0 linux|macos PACKAGE_INDEX_FILE" && exit 1

echo "Installing packages..."

platform="$1"
case "$platform" in
  linux)
    echo "Updating package index..."
    sudo apt-get update || echo "Failed to update package index!"

    installer="sudo apt-get -y install"
    ;;
  macos)
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL $HOMEBREW_INSTALLER)"

    echo "Updating package index..."
    brew update || echo "Failed to update package index!"

    installer="brew install"
    ;;
  *)
    echo "Platform '$platform' not supported!"
    exit 1
    ;;
esac

package_index="$2"
packages=$(cat "$package_index" | tr ";" "\n")
echo "$packages" | while read -r package; do
  echo "Installing package '$package'..."
  if $installer $package; then
    echo "Installed package '$package' successfully!"
  else
    echo "Failed to install package '$package'!"
    exit 1
  fi
done

echo "Packages installed!"
