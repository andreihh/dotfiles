#!/bin/bash

# Downloads the dotfiles repository and runs for the specified system:
# - the dotfile backup script
# - the package installer script
# - the dotfile installer script
# - the given setup scripts
#
# After the installation is complete, it sets up the remote git repository.
#
# If any step in the installation fails, you may fix the issues manually and
# run this script again. However, you must move any generated backups to a
# different location.
#
# Requires `unzip` and `curl`.

readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly BACKUP_DIR="$HOME/.dotfiles.bak"
readonly GITHUB_REPO="https://github.com/andreihh/.dotfiles"
readonly REPO_ZIP="$GITHUB_REPO/archive/master.zip"
readonly REPO_GIT="$GITHUB_REPO.git"

readonly BACKUP_DOTFILES="$INSTALLER_DIR/backup_dotfiles.sh"
readonly INSTALL_DOTFILES="$INSTALLER_DIR/install_dotfiles.sh"
readonly INSTALL_PACKAGES="$INSTALLER_DIR/install_packages.sh"

[[ $# -lt 2 ]] &&
  echo "Usage: $0 linux|macos PACKAGE_INDEX_FILE SETUP_SCRIPTS..." &&
  exit 1

echo "Installing dotfiles repository..."

echo "Downloading repository..."
curl -LO "$REPO_ZIP" || exit 1

echo "Unpacking repository..."
unzip master.zip \
  && rm master.zip \
  && mv .dotfiles-master "$DOTFILES_DIR" \
  || exit 1

echo "Setting execute permissions on install scripts..."
chmod +x "$BACKUPDOTFILES" "$INSTALL_DOTFILES" "$INSTALL_PACKAGES" || exit 1

platform="$1"; shift
package_index="$1"; shift

"$BACKUP_DOTFILES" "$BACKUP_DIR" || exit 1
"$INSTALL_DOTFILES" "$platform" || exit 1
"$INSTALL_PACKAGES" "$platform" "$package_index" || exit 1

echo "Running setup scripts..."
for script in "$@"; do
  echo "Running script '$script'..."
  chmod +x "$script" && "$script" || exit 1
done

echo "Initializing remote git repository..."
cd "$DOTFILES_DIR" \
  && git init \
  && git remote add origin "$REPO_GIT" \
  && git fetch \
  && git checkout -t -f origin/master \
  || exit 1

echo "Installation completed!"
