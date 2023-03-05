#!/usr/bin/env bash

# Downloads the dotfiles repository, runs the setup script, and initializes the
# remote git repository.

readonly GITHUB_REPO="https://github.com/andreihh/.dotfiles"
readonly REPO_ZIP="$GITHUB_REPO/archive/master.zip"
readonly GIT_REPO="$GITHUB_REPO.git"
readonly DOTFILES_DIR="$HOME/.dotfiles"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Downloading repository..."
wget "$REPO_ZIP" \
  && unzip master.zip \
  && rm master.zip \
  && mv .dotfiles-master "$DOTFILES_DIR" \
  && cd "$DOTFILES_DIR" \
  || exit 1

echo -e "\nExecuting system setup script..."
chmod +x setup.sh && ./setup.sh || exit 1

echo -e "\nInitializing remote git repository..." \
  && git init \
  && git remote add origin "$GIT_REPO" \
  && git fetch \
  && git checkout -t -f origin/master \
  || exit 1

echo -e "\nInstallation completed!"
