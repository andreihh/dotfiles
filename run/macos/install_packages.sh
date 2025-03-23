#!/bin/bash -e
#
# Installs required packages. Must run before all other scripts.
#
# Requires Homebrew.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating package index..."
brew update

echo "Installing packages..."
brew install \
  firefox git stow curl wget zip gzip unzip make gnupg \
  --cask ghostty tmux lm-sensors urlscan vim nvim \
  fzf fd ripgrep bat lazygit tree calc dos2unix --cask alt-tab \
  \
  python3 gcc cmake \
  \
  --cask mactex biber \
  \
  --cask keepassxc --cask vlc pdftk-java ffmpeg graphviz plantuml

FDFIND="$(command -v fdfind)"
readonly FDFIND
if [[ -f "${FDFIND}" ]]; then
  echo "Linking 'fd' to 'fdfind'..."
  ln -sfv "${FDFIND}" "${HOME}/.local/bin/fd"
fi

BATCAT="$(command -v batcat)"
readonly BATCAT
if [[ -f "${BATCAT}" ]]; then
  echo "Linking 'bat' to 'batcat'..."
  ln -sfv "${BATCAT}" "${HOME}/.local/bin/bat"
fi

echo "Packages installed successfully!"
