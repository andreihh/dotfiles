#!/bin/bash -e

# Installs the Vim plugins configured in `~/.vimrc`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Vim plugins..."
vim -c ':PlugInstall' ':FZF --version' -c ':qa!'

echo "Setting up latest fzf version packaged with Vim..."
ln -svf "$HOME/.vim/plugged/fzf/bin/fzf" "$HOME/.local/bin/fzf"

echo "Installed Vim plugins successfully!"
