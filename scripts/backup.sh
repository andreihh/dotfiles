#!/bin/bash

# Backs up all dotfiles to the given directory.
#
# If the backup directory already exists or a single file backup fails, aborts
# the backup and reports a failure.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

[[ $# -ne 1 ]] && echo "Usage: $0 BACKUP_DIR" && exit 1

function backup_file_to() {
  local file="$1"
  local backup_dir="$2"

  echo "Backing up '$file'..."
  [[ ! -e "$file" ]] && echo "'$file' doesn't exist!" && return 0

  if ! cp -Pv "$file" "$backup_dir/"; then
    echoerr "Failed to back up '$file'!"
    return 1
  fi
}

function backup_dotfiles_to() {
  local directory="$1"
  local backup_dir="$2"
  for file in "$directory"/.[!.]*; do
    dotfile=$(basename "$file")
    backup_file_to "$HOME/$dotfile" "$backup_dir" || return 1
  done
}

backup_dir="$1"
echo "Setting up backup directory '$backup_dir'..."
[[ -e "$backup_dir" ]] \
  && echoerr "You must move the existing backup '$backup_dir' elsewhere!" \
  && exit 1
mkdir -p "$backup_dir" || exit 1

backup_dotfiles_to "$DOTFILES_DIR" "$backup_dir" || exit 1

platform=$(get_platform)
if [[ ! -z "$platform" ]]; then
  backup_dotfiles_to "$DOTFILES_DIR/$platform" "$backup_dir" || exit 1
fi

echo "Backup completed!"
