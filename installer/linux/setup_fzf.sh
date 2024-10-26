#!/bin/bash -e

# Installs `fzf` for Linux systems.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly FZF_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/fzf"
readonly BIN="${HOME}/.local/bin"

echo "Cleaning up prior 'fzf' installation..."
rm -rf "${FZF_HOME}"

echo "Downloading 'fzf'..."
git clone --depth 1 https://github.com/junegunn/fzf.git "${FZF_HOME}"

echo "Running 'fzf' installer..."
"${FZF_HOME}/install" --xdg --bin

echo "Setting up 'fzf' symlink in user 'bin'..."
ln -svf "${FZF_HOME}/bin/fzf" "${BIN}/fzf"

echo "Installed 'fzf' successfully!"
