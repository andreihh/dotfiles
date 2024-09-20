#!/bin/bash -e

# Installs the Vim plugins configured in `~/.vimrc`.
#
# Requires the `fzf` plugin installed under `~/.fzf`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Vim plugins..."
vim -c ':PlugInstall' -c ':FZF --version' -c ':qa!'

echo "Setting up latest fzf version packaged with Vim..."
~/.fzf/install --all

echo "Installed Vim plugins successfully!"
