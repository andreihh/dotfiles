#!/bin/bash

# Installs the dotfiles on the current system.
#
# The program will back up the dotfiles to the standard backup location and
# install them from the standard repository location via a symlink in the home
# directory. If the backup of a specific file fails, it will not install it.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly DOTFILES=\
".bashrc .bash_profile .bash_logout .bash_prompt .bash_aliases .inputrc "\
".exports .editorconfig .vimrc .tmux.conf .gitconfig .ideavimrc "\
".latexmkrc .prettierrc .style.yapf .clang-format "

readonly LINUX_DOTFILES=\
".platform_utils "

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

function install_dotfile() {
  local file="$1"
  local filename=$(basename "$file")

  echo "Installing dotfile '$file'..."
  [[ -e "$file" ]] \
    && ln -sfv "$file" "$HOME/$filename" \
    || echoerr "Failed to install dotfile '$file'!"
}

echo "Setting up dotfiles..."
for file in $DOTFILES; do
  install_dotfile "$DOTFILES_DIR/$file"
done

platform=$(get_platform)
case "$platform" in
  linux) platform_dotfiles="$LINUX_DOTFILES" ;;
  # MacOS is not supported.
  *) platform_dotfiles="" ;;
esac

echo "Setting up platform-specific dotfiles..."
for file in $platform_dotfiles; do
  install_dotfile "$DOTFILES_DIR/$platform/$file"
done

echo "Dotfiles installed!"
