#!/bin/bash -e

# Installs the `~/.dotfiles` as symlinks in the home directory.
#
# If installing a single file fails, aborts the installation and reports the
# failure.

readonly CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly DOTFILES_HOME="$CONFIG_HOME/dotfiles"

usage() {
  cat << EOF
  Usage: $0 [-h] [-d] [-b <backup_dir>]

    -d  Debug / dry run mode (simulate all actions, but do not execute them).
    -b  Backup directory where dotfiles should be copied to.
    -h  Print this message and exit.
EOF
}

while getopts "db:h" option; do
  case "$option" in
    d)
      debug="-d"
      stow_opts="-nvv"
      ;;
    b) backup_dir="$OPTARG" ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing dotfiles..."
[[ -n "$debug" ]] && echo "Running in debug mode!"

if [[ ! -d "$DOTFILES_HOME" ]]; then
  echo "Dotfiles repository '$DOTFILES_HOME' is missing!"
  exit 1
fi

echo "Checking that the Git repository is clean..."
if [[ $(git -C "$DOTFILES_HOME" status --porcelain 2> /dev/null) ]]; then
  echo "You must commit changes to the Git repository and get to a clean state!"
  [[ -n "$debug" ]] || exit 1
fi

if [[ -n "$backup_dir" ]]; then
  if [[ -e "$backup_dir" ]]; then
    echo "You must move the existing backup '$backup_dir' elsewhere!"
    [[ -n "$debug" ]] || exit 1
  fi

  echo "Setting up backup directory '$backup_dir'..."
  [[ -n "$debug" ]] || mkdir -p "$backup_dir"
fi

echo "Stowing dotfiles, adopting conflicting files..."
stow $stow_opts --no-folding --adopt -t "$HOME" -d "$DOTFILES_HOME" .

if [[ -n "$backup_dir" ]]; then
  echo "Backing up dotfiles..."
  [[ -n "$debug" ]] || cp -Prv "$DOTFILES_HOME" "$backup_dir"
fi

echo "Reverting changes from adopted files..."
[[ -n "$debug" ]] || git -C "$DOTFILES_HOME" checkout .

echo "Dotfiles installed successfully!"
