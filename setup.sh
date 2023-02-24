#!/usr/bin/env bash

# This script will install dotfiles and preferences on the current machine.
#
# The dotfiles repository must be located in the `~/.dotfiles` directory.
#
# It will backup existing dotfiles to `~/.dotfiles.bak`, and will abort the
# installation if the backup directory already exists. If the backup of a
# specific file fails, it will not install the corresponding dotfile.
#
# It will replace every dotfile in the home directory with a symlink to the
# corresponding file in the `~/.dotfiles` repository.
#
# After installing the dotfiles, it will run the platform-specific setup to
# install required packages and other customizations.
#
# Lastly, it will attempt to compile and install the Vim `YouCompleteMe` plugin.
#
# If any step in the installation fails, you may fix the issues manually and
# run this script again. However, you must move any generated backups to a
# different location.

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

# Prints the given message in red.
function echoerr() {
  echo -e "\033[0;31m${1}\033[0m"
}

function setup_backup_directory() {
  local backup_dir="$1"

  echo "Setting up backup directory '$backup_dir'..."
  [ -e "$backup_dir" ] \
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
  [ ! -e "$file" ] && echo "'$file' doesn't exist!" && return 0

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
  [ -e "$link" ] \
    && echoerr "Can't set up symlink because '$link' already exists!" \
    && return 1

  if ln -s "$target" "$link"; then
    echo "Symlink '$link' created!"
  else
    echoerr "Failed to create symlink '$link'!"
    return 1
  fi
}


repository="$HOME/.dotfiles"
backup="$HOME/.dotfiles.bak"
dotfiles=\
".bashrc .bash_profile .bash_logout .bash_prompt .bash_aliases .exports bin "\
".inputrc .editorconfig .vimrc .vim .ideavimrc "\
".gitconfig .gradle .latexmkrc "

shopt -s nocasematch
case "$OSTYPE" in
  linux*)
    platform="linux"
    platform_dotfiles=".platform_utils"
    ;;
  *)
    # MacOS (pattern "darwin*") is not supported.
    # BSD flavors (pattern "*bsd*") are not supported.
    platform=""
    platform_dotfiles=""
    ;;
esac
shopt -u nocasematch

platform_setup_script="$repository/$platform/setup.sh"
ycm_installer="$repository/.vim/bundle/YouCompleteMe/install.py"

[ -z "$platform" ] && echoerr "Unsupported platform '$platform'!" && exit 1
[ ! -e "$repository" ] \
  && echoerr "You must clone the dotfiles repository in '$HOME'!" \
  && exit 1

setup_backup_directory "$backup" || exit 1

echo -e "\nSetting execution permission for '$repository/bin' scripts..."
chmod -R 755 "$repository/bin" \
  && echo "Execution permissions on '$repository/bin' scripts set!" \
  || echoerr "Failed to set execution permissions on '$repository/bin' scripts!"

echo -e "\nSetting up dotfiles..."
for file in $dotfiles; do
  [ ! -e "$repository/$file" ] \
    && echoerr "Missing '$file' from '$repository'!" \
    && continue

  backup_file_to "$HOME/$file" "$backup" \
    && make_symlink "$repository/$file" "$HOME/$file"
done

echo -e "\nSetting up platform-specific dotfiles..."
for file in $platform_dotfiles; do
  [ ! -e "$repository/$platform/$file" ] \
    && echoerr "Missing '$platform/$file' from '$repository'!" \
    && continue

  backup_file_to "$HOME/$file" "$backup" \
    && make_symlink "$repository/$platform/$file" "$HOME/$file"
done

echo -e "\nRunning '$platform' platform setup..."
chmod +x "$platform_setup_script" && $platform_setup_script \
  && echo "'$platform' platform setup completed!" \
  || echoerr "'$platform' platform setup failed!"

echo -e "\nInstalling 'YouCompleteMe' Vim plugin..."
chmod +x "$ycm_installer" && $ycm_installer \
  && echo "'YouCompleteMe' Vim plugin installed!" \
  || echoerr "Failed to install 'YouCompleteMe' Vim plugin!"

echo -e "\nDone!"
