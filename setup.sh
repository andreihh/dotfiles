#!/usr/bin/env bash

# Installs the dotfiles and preferences on the current system.
#
# The dotfiles repository must be located in the `~/.dotfiles` directory.
#
# The program will backup existing dotfiles to `~/.dotfiles.bak`, and will abort
# the installation if the backup directory already exists. If the backup of a
# specific file fails, it will not install the corresponding dotfile.
#
# It will replace every dotfile in the home directory with a symlink to the
# corresponding file in the `~/.dotfiles` repository.
#
# After installing the dotfiles, it will run the platform-specific setup to
# install required packages and other customizations.
#
# If any step in the installation fails, you may fix the issues manually and
# run this script again. However, you must move any generated backups to a
# different location.

readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly BACKUP_DIR="$HOME/.dotfiles.bak"
readonly DOTFILES=\
".bashrc .bash_profile .bash_logout .bash_prompt .bash_aliases .exports "\
".inputrc .editorconfig .vimrc .ideavimrc .tmux.conf "\
".gitconfig .latexmkrc "

shopt -s nocasematch
case "$OSTYPE" in
  linux*)
    readonly PLATFORM="linux"
    readonly PLATFORM_DOTFILES=".platform_utils"
    ;;
  *)
    # MacOS (pattern `darwin*`) is not supported.
    # BSD flavors (pattern `*bsd*`) are not supported.
    readonly PLATFORM=""
    readonly PLATFORM_DOTFILES=""
    ;;
esac
shopt -u nocasematch

readonly PLATFORM_SETUP_SCRIPT="$DOTFILES_DIR/$PLATFORM/setup.sh"

readonly TMUX_TPM_GITHUB_REPO="https://github.com/tmux-plugins/tpm"
readonly TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1
[[ -z "$PLATFORM" ]] && echo "System platform is not supported!" && exit 1

function setup_backup_directory() {
  local backup_dir="$1"

  echo "Setting up backup directory '$backup_dir'..."
  [[ -e "$backup_dir" ]] \
    && echoerr "You must move the existing backup '$backup_dir' elsewhere!" \
    && return 1

  if mkdir -p "$backup_dir"; then
    echo "Backup directory '$backup_dir' setup completed!"
  else
    echoerr "Failed to set up backup directory '$backup_dir'!"
    return 1
  fi
}

function backup_file_to() {
  local file="$1"
  local backup_dir="$2"

  echo "Backing up '$file'..."
  [[ ! -e "$file" ]] && echo "'$file' doesn't exist!" && return 0

  if mv -v "$file" "$backup_dir/"; then
    echo "'$file' backed up successfully!"
  else
    echoerr "Failed to back up '$file'!"
    return 1
  fi
}

function make_symlink() {
  local target="$1"
  local link="$2"

  echo "Setting up symlink for '$target'..."
  [[ -e "$link" ]] \
    && echoerr "Can't set up symlink because '$link' already exists!" \
    && return 1

  if ln -s "$target" "$link"; then
    echo "Symlink '$link' created!"
  else
    echoerr "Failed to create symlink '$link'!"
    return 1
  fi
}

echo "Starting system setup..."

echo -e "\nSourcing essential bash aliases..."
. "$DOTFILES_DIR/.bash_aliases" || exit 1

setup_backup_directory "$BACKUP_DIR" || exit 1

echo -e "\nSetting up dotfiles..."
for file in $DOTFILES; do
  [[ ! -e "$DOTFILES_DIR/$file" ]] \
    && echoerr "Missing '$file' from '$DOTFILES_DIR'!" \
    && continue

  backup_file_to "$HOME/$file" "$BACKUP_DIR" \
    && make_symlink "$DOTFILES_DIR/$file" "$HOME/$file"
done

echo -e "\nSetting up platform-specific dotfiles..."
for file in $PLATFORM_DOTFILES; do
  [[ ! -e "$DOTFILES_DIR/$PLATFORM/$file" ]] \
    && echoerr "Missing '$PLATFORM/$file' from '$DOTFILES_DIR'!" \
    && continue

  backup_file_to "$HOME/$file" "$BACKUP_DIR" \
    && make_symlink "$DOTFILES_DIR/$PLATFORM/$file" "$HOME/$file"
done

echo -e "\nExecuting '$PLATFORM' setup script..."
chmod +x "$PLATFORM_SETUP_SCRIPT" && $PLATFORM_SETUP_SCRIPT || exit 1

echo -e "\nSetting up TMUX plugin manager..."
if [[ ! -d "$HOME_TMUX_TPM" ]]; then
  git clone "$TMUX_TPM_GITHUB_REPO" "$TMUX_TPM_DIR" \
    && echo "TMUX plugin manager setup completed!" \
    || echoerr "Failed to set up TMUX plugin manager!"
else
  echo "TMUX plugin manager already installed!"
fi

echo -e "\nSystem setup completed!"
