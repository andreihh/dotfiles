#!/bin/bash -e

# Configures the Tmux Plugin Manager.
#
# Requires `git`.

readonly TMUX_TPM_GITHUB_REPO="https://github.com/tmux-plugins/tpm"
readonly TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing Tmux Plugin Manager..."
if [[ ! -d "$TMUX_TPM_DIR" ]]; then
  git clone "$TMUX_TPM_GITHUB_REPO" "$TMUX_TPM_DIR"
  echo "Tmux Plugin Manager installed successfully!"
else
  echo "Tmux Plugin Manager already installed!"
fi

echo "Installing 'tmux' plugins..."
~/.tmux/plugins/tpm/scripts/install_plugins.sh
echo "Installed 'tmux' plugins successfully!"
