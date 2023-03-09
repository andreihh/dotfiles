#!/usr/bin/env bash

# Configures the TMUX plugin manager. Requires git.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly TMUX_TPM_GITHUB_REPO="https://github.com/tmux-plugins/tpm"
readonly TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Setting up TMUX plugin manager..."
if [[ ! -d "$TMUX_TPM_DIR" ]]; then
  git clone "$TMUX_TPM_GITHUB_REPO" "$TMUX_TPM_DIR" \
    && echo "TMUX plugin manager setup completed!" \
    || echoerr "Failed to set up TMUX plugin manager!"
else
  echo "TMUX plugin manager already installed!"
fi
