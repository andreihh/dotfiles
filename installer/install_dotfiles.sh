#!/bin/bash

# Installs the `~/.dotfiles` for the specified system ('linux' or 'macos') as
# symlinks in the home directory.
#
# If installing a single file fails, aborts the installation and reports the
# failure.

[[ $# -ne 1 ]] && echo "Usage: $0 linux|macos" && exit 1

echo "Installing dotfiles..."

platform="$1"
case "$platform" in
  linux) ;;
  macos) ;;
  *) echo "Platform '$platform' not supported!"; exit 1 ;;
esac

for file in "$HOME/.dotfiles"{,/$platform}/.[!.]*; do
  if [[ ! -f "$file" ]]; then
    continue
  fi
  filename=$(basename "$file")
  echo "Installing dotfile '$file'..."
  if ln -sfv "$file" "$HOME/$filename"; then
    echo "Installed '$file' successfully!"
  else
    echo "Failed to install '$file'!"
    exit 1
  fi
done

echo "Dotfiles installed!"
