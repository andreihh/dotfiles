#!/bin/bash -e

# Installs `fzf` for Linux systems.
#
# Requires `git`.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly FZF_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fzf"
readonly BIN="${HOME}/.local/bin"

echo "Cleaning up prior 'fzf' installation..."
rm -rf "${FZF_DIR}"

echo "Downloading 'fzf'..."
git clone --depth 1 https://github.com/junegunn/fzf.git "${FZF_DIR}"

echo "Running 'fzf' installer..."
"${FZF_DIR}/install" --xdg --bin

echo "Setting up 'fzf' symlink in user 'bin'..."
ln -svf "${FZF_DIR}/bin/fzf" "${BIN}/fzf"

echo "Installed 'fzf' successfully!"
