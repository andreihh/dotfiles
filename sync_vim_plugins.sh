#!/usr/bin/env bash

# This script will update the Vim plugins.

readonly DOTFILES_DIR="$HOME/.dotfiles"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

cd "$DOTFILES_DIR" \
  && git submodule sync --recursive \
  && git submodule update --init --recursive --remote
