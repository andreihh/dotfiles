#!/bin/bash

# Backs up all dotfiles to the given directory.
#
# If the backup directory already exists or a single file backup fails, aborts
# the backup and reports a failure.

[[ $# -ne 1 ]] && echo "Usage: $0 BACKUP_DIR" && exit 1

backup_dir="$1"
echo "Setting up backup directory '$backup_dir'..."
[[ -e "$backup_dir" ]] \
  && echoerr "You must move the existing backup '$backup_dir' elsewhere!" \
  && exit 1
mkdir -p "$backup_dir" || exit 1

for file in "$HOME"/.[!.]*; do
  if [[ ! -f "$file" ]]; then
    continue
  fi
  echo "Backing up '$file'..."
  if ! cp -Pv "$file" "$backup_dir/"; then
    echo "Failed to back up '$file'!"
    exit 1
  fi
done

echo "Backup completed!"
