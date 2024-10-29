#!/bin/bash -e
#
# Installs `fzf` from sources for Linux systems.
#
# Requires `git`.
#
# This is needed because the `fzf` version available in package managers is too
# old and doesn't support shell completion (requires version 0.48.0 or newer).

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly FZF_DIR="${HOME}/.local/src/fzf"

echo "Installing 'fzf'..."

echo "Cleaning up prior 'fzf' installation..."
rm -rf "${FZF_DIR}"

echo "Downloading 'fzf'..."
git clone --depth 1 https://github.com/junegunn/fzf.git "${FZF_DIR}"

echo "Running 'fzf' installer..."
"${FZF_DIR}/install" --bin

echo "Setting up 'fzf' symlink in user 'bin'..."
ln -svf "${FZF_DIR}/bin/fzf" "${HOME}/.local/bin/fzf"

echo "Installed 'fzf' successfully!"
