#!/usr/bin/env bash

# Runs the given backup and setup scripts.
#
# The program will:
# - download the dotfiles repository to `~/.dotfiles`
# - backup existing dotfiles to `~/.dotfiles.bak`, aborting the installation if
#   the backup fails
# - run all the provided setup scripts
# - initialize the remote dotfiles git repository
#
# If any step in the installation fails, you may fix the issues manually and
# run this script again. However, you must move any generated backups to a
# different location.
#
# Requires unzip and either wget or curl.

readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly BACKUP_DIR="$HOME/.dotfiles.bak"
readonly GITHUB_REPO="https://github.com/andreihh/.dotfiles"
readonly REPO_ZIP="$GITHUB_REPO/archive/master.zip"
readonly GIT_REPO="$GITHUB_REPO.git"

[[ $# -eq 0 ]] && echo "Usage: $0 BACKUP_SCRIPT SETUP_SCRIPTS..." && exit 1

echo "Downloading repository..."
wget "$REPO_ZIP" || curl -LO "$REPO_ZIP" || exit 1

echo -e "\nUnpacking repository..."
unzip master.zip \
  && rm master.zip \
  && mv .dotfiles-master "$DOTFILES_DIR" \
  || exit 1

backup_script="$1"; shift
echo -e "\nRunning backup script '$backup_script'..."
chmod +x "$backup_script" && "$backup_script" "$BACKUP_DIR" || exit 1

echo -e "\nRunning setup scripts..."
for script in "$@"; do
  echo -e "\nRunning script '$script'..."
  chmod +x "$script" && "$script" || exit 1
done

echo -e "\nInitializing remote git repository..." \
cd "$DOTFILES_DIR" \
  && git init \
  && git remote add origin "$GIT_REPO" \
  && git fetch \
  && git checkout -t -f origin/master \
  || exit 1

echo -e "\nInstallation completed!"
