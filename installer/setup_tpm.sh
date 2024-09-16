#!/bin/bash

# Configures the Tmux Plugin Manager.
#
# Requires `git`.

readonly TMUX_TPM_GITHUB_REPO="https://github.com/tmux-plugins/tpm"
readonly TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

if [[ ! -d "$TMUX_TPM_DIR" ]]; then
  echo "Setting up Tmux Plugin Manager..."
  if git clone "$TMUX_TPM_GITHUB_REPO" "$TMUX_TPM_DIR"; then
    echo "Tmux Plugin Manager setup completed!"
  else
    echo "Failed to set up Tmux Plugin Manager!"
    exit 1
  fi
else
  echo "Tmux Plugin Manager already installed!"
fi
