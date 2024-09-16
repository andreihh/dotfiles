#!/bin/bash -e

# Downloads the dotfiles repository and runs:
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
# Supports Linux and MacOS. Requires `unzip` and `curl`.

readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly BACKUP_DIR="$HOME/.dotfiles.bak"
readonly GITHUB_REPO="https://github.com/andreihh/.dotfiles"
readonly REPO_ZIP="$GITHUB_REPO/archive/master.zip"
readonly REPO_GIT="$GITHUB_REPO.git"

readonly INSTALLER_DIR="$DOTFILES_DIR/installer"
readonly BACKUP_DOTFILES="$INSTALLER_DIR/backup_dotfiles.sh"
readonly INSTALL_DOTFILES="$INSTALLER_DIR/install_dotfiles.sh"
readonly INSTALL_PACKAGES="$INSTALLER_DIR/install_packages.sh"

[[ $# -lt 1 ]] && echo "Usage: $0 PACKAGE_INDEX_FILE SETUP_SCRIPTS..." && exit 1

echo "Installing dotfiles repository..."

echo "Downloading repository..."
curl -LO "$REPO_ZIP"

echo "Unpacking repository..."
unzip master.zip
rm master.zip
mv .dotfiles-master "$DOTFILES_DIR"

echo "Running backup and install scripts..."
package_index="$1"
shift
chmod +x "$BACKUP_DOTFILES" "$INSTALL_DOTFILES" "$INSTALL_PACKAGES"
"$BACKUP_DOTFILES" "$BACKUP_DIR"
"$INSTALL_DOTFILES"
"$INSTALL_PACKAGES" "$package_index"

echo "Running setup scripts..."
for script in "$@"; do
  echo "Running script '$script'..."
  chmod +x "$script"
  "$script"
done

echo "Initializing remote git repository..."
cd "$DOTFILES_DIR"
git init
git remote add origin "$REPO_GIT"
git fetch
git checkout -t -f origin/master

echo "Installation complete!"
