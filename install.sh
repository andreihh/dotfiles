#!/usr/bin/env bash

# This script will download the dotfiles repository, run the setup script, and
# initialize the remote git repository.

REPO_ZIP="https://github.com/andreihh/.dotfiles/archive/refs/heads/master.zip"
GIT_REPO="https://github.com/andreihh/.dotfiles.git"

echo "Downloading repository..."
cd ~ \
  && curl -LO "$REPO_ZIP" \
  && unzip master.zip \
  && rm master.zip \
  && mv .dotfiles-master .dotfiles \
  && cd .dotfiles \
  || exit 1

echo "Executing setup script..."
  && chmod +x setup.sh && ./setup.sh \
  || exit 1

echo "Initializing remote git repository..."
  && git init \
  && git remote add origin "$GIT_REPO" \
  && git fetch \
  && git checkout -t origin/master \
  || exit 1

echo "Installation complete!"
