#!/bin/bash -e

# Installs the `~/.dotfiles` as symlinks in the home directory.
#
# If installing a single file fails, aborts the installation and reports the
# failure.
#
# Supports Linux and MacOS.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing dotfiles..."

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

for file in "$HOME/.dotfiles"{,/$platform}/.[!.]*; do
  if [[ ! -f "$file" ]]; then
    continue
  fi
  echo "Installing dotfile '$file'..."
  filename=$(basename "$file")
  ln -sfv "$file" "$HOME/$filename"
done

echo "Dotfiles installed successfully!"
