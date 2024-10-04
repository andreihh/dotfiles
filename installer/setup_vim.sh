#!/bin/bash -e

# Installs the Vim plugins configured in `~/.vimrc`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

# Remove after https://github.com/vim/vim/pull/14182 is included in Vim release.
echo "Setting up Vim legacy runtime..."
ln -svf "${XDG_CONFIG_HOME:-$HOME/.config}/vim" "$HOME/.vim"

echo "Installing Vim plugins..."
vim -c ':PlugInstall' -c ':qa!'

echo "Installed Vim plugins successfully!"
