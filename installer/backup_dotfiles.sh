#!/bin/bash -e

# Backs up all dotfiles to the given directory.
#
# If the backup directory already exists or a single file backup fails, aborts
# the backup and reports the failure.

[[ $# -ne 1 ]] && echo "Usage: $0 BACKUP_DIR" && exit 1

backup_dir="$1"
echo "Setting up backup directory '$backup_dir'..."
if [[ -e "$backup_dir" ]]; then
  echo "You must move the existing backup '$backup_dir' elsewhere!"
  exit 1
fi
mkdir -p "$backup_dir"

for file in "$HOME"/.[!.]*; do
  if [[ ! -f "$file" ]]; then
    continue
  fi
  echo "Backing up '$file'..."
  cp -Pv "$file" "$backup_dir/"
done

echo "Backup complete!"
