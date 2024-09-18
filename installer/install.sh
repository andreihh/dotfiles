#!/bin/bash -e

# Downloads the dotfiles repository and runs:
# - the dotfile backup script
# - the package installer script
# - the dotfile installer script
# - the given setup scripts
#
# After the installation is complete, it sets up the remote git repository.
#
# If no setup scripts are provided, it will run all scripts that match the
# 'setup_*.sh' pattern.
#
# If no arguments are provided, it will use the platform-specific
# 'package_index.txt'.
#
# If any step in the installation fails, you may fix the issues manually and
# run this script again. However, you must move any generated backups to a
# different location.
#
# Supports Linux and MacOS. Requires `unzip` and `curl`.
#
# Usage: $0 [PACKAGE_INDEX_FILE] [SETUP_SCRIPTS...]

readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly BACKUP_DIR="$HOME/.dotfiles.bak"
readonly REPO="https://github.com/andreihh/.dotfiles"
readonly BRANCH="main"
readonly REPO_ZIP="$REPO/archive/$BRANCH.zip"

readonly INSTALLER_DIR="$DOTFILES_DIR/installer"
readonly BACKUP_DOTFILES="$INSTALLER_DIR/backup_dotfiles.sh"
readonly INSTALL_DOTFILES="$INSTALLER_DIR/install_dotfiles.sh"
readonly INSTALL_PACKAGES="$INSTALLER_DIR/install_packages.sh"

# Prints the given message in red to stderr.
function echoerr() {
  echo -e "\033[0;31m$@\033[0m" >&2
}

echo "Installing dotfiles repository..."

shopt -s nocasematch
case "$OSTYPE" in
  linux*) platform="linux" ;;
  darwin*) platform="macos" ;;
  *)
    echo "Platform '$OSTYPE' not supported!"
    exit 1
    ;;
esac
shopt -u nocasematch

echo "Cleaning up prior installations..."
rm -rf "$BRANCH.zip" ".dotfiles-$BRANCH/" "$DOTFILES_DIR/"

echo "Downloading repository..."
curl -LO "$REPO_ZIP"

echo "Unpacking repository..."
unzip "$BRANCH.zip"
rm "$BRANCH.zip"
mv ".dotfiles-$BRANCH" "$DOTFILES_DIR"

if [[ $# -gt 0 ]]; then
  package_index="$1"
  shift
else
  package_index="$INSTALLER_DIR/$platform/package_index.txt"
fi

echo "Running backup and install scripts..."
chmod +x "$BACKUP_DOTFILES" "$INSTALL_DOTFILES" "$INSTALL_PACKAGES"
"$BACKUP_DOTFILES" "$BACKUP_DIR"
"$INSTALL_DOTFILES"
"$INSTALL_PACKAGES" "$package_index"

if [[ $# -gt 0 ]]; then
  setup_scripts="$@"
else
  setup_scripts=$(echo "$INSTALLER_DIR"{,/$platform}/setup_*.sh)
fi

echo "Running setup scripts..."
for script in $setup_scripts; do
  echo "Running script '$script'..."
  chmod +x "$script"
  if "$script"; then
    echo "Script '$script' ran successfully!"
  else
    echoerr "Script '$script' failed!" >&2
  fi
done

echo "Initializing remote git repository..."
cd "$DOTFILES_DIR"
git init
git remote add origin "$REPO.git"
git fetch
git checkout -t -f "origin/$BRANCH"

echo "Installation complete!"
