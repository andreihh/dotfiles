#!/bin/bash -e

# Installs the Vim plugins configured in `~/.vimrc`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Vim plugins..."
vim -c ':PlugInstall' -c ':qa!'

echo "Installed Vim plugins successfully!"
