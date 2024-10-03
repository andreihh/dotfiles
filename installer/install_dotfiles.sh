#!/bin/bash -e

# Installs the `~/.dotfiles` as symlinks in the home directory.
#
# If installing a single file fails, aborts the installation and reports the
# failure.

usage() {
  cat << EOF
  Usage: $0 [-h] [-d] -o <operating-system>

    -d  Debug / dry run mode (simulate all actions, but do not execute them).
    -h  Print this message and exit.
EOF
}

while getopts "dh" option; do
  case "$option" in
    d) debug="-d" ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing dotfiles..."
[[ -n "$debug" ]] && echo "Running in debug mode!"

for file in "$HOME/.dotfiles"/.[!.]*; do
  [[ ! -f "$file" ]] && continue
  echo "Installing dotfile '$file'..."
  filename=$(basename "$file")
  [[ -n "$debug" ]] || ln -sfv "$file" "$HOME/$filename"
done

echo "Dotfiles installed successfully!"
