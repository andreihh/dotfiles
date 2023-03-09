#!/usr/bin/env bash

# Installs the dotfiles on the current system.
#
# The program will back up the dotfiles to the standard backup location and
# install them from the standard repository location via a symlink in the home
# directory. If the backup of a specific file fails, it will not install it.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly DOTFILES=\
".bashrc .bash_profile .bash_logout .bash_prompt .bash_aliases .exports "\
".inputrc .editorconfig .vimrc .ideavimrc .tmux.conf "\
".gitconfig .latexmkrc "
readonly LINUX_DOTFILES=\
".platform_utils "

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

function try_install_dotfile() {
  local file="$1"
  local dotfile=$(basename "$file")

  echo "Installing dotfile '$dotfile'..."
  [[ -e "$file" ]] \
    && ln -sf "$file" "$HOME/$dotfile" \
    || echoerr "Failed to install dotfile '$file'!"
}

echo "Setting up dotfiles..."
for dotfile in $DOTFILES; do
  try_install_dotfile "$DOTFILES_DIR/$dotfile"
done

platform="$(get_platform)"
case "$platform" in
  linux)
    platform_dotfiles="$LINUX_DOTFILES"
    ;;
  *)
    # MacOS is not supported.
    platform_dotfiles=""
    ;;
esac

echo "Setting up platform-specific dotfiles..."
for file in $platform_dotfiles; do
  try_install_dotfile "$DOTFILES_DIR/$platform/$file"
done

echo "Dotfiles installed!"
