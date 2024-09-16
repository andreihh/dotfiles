#!/bin/bash -e

# Installs the specified packages.
#
# The package index file must delimit packages by ';'. Prepend any required
# special arguments for the installer to the package name (e.g., '--cask').
#
# Supports Linux and MacOS. Requires `apt` on Linux and `curl` on MacOS.

[[ $# -ne 1 ]] && echo "Usage: $0 PACKAGE_INDEX_FILE" && exit 1

echo "Installing packages..."

shopt -s nocasematch
case "$OSTYPE" in
  linux*)
    echo "Updating package index..."
    sudo apt-get update

    installer="sudo apt-get -y install"
    ;;
  darwin*)
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL $HOMEBREW_INSTALLER)"

    echo "Updating package index..."
    brew update

    installer="brew install"
    ;;
  *)
    echo "Platform '$platform' not supported!"
    exit 1
    ;;
esac
shopt -u nocasematch

package_index="$1"
packages=$(cat "$package_index" | tr ";" "\n")
echo "$packages" | while read -r package; do
  echo "Installing package '$package'..."
  $installer $package
done

echo "Packages installed successfully!"
