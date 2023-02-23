#!/usr/bin/env bash

# This script will update the Vim plugins.

echo "Updating Vim plugins..."
cd ~/.dotfiles \
  && git submodule sync --recursive \
  && git submodule update --init --recursive --remote \
  && echo "Vim plugins updated successfully!"
