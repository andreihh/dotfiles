#!/bin/bash -e
#
# Installs required packages. Must run before all other scripts.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
readonly HOMEBREW_SHELLENV="${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d/00-brew.sh"

if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  # `curl` should be installed by default on MacOS.
  [[ -n "${debug}" ]] || /bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALLER})"
  echo "You must write the 'brew shellenv' output to '${HOMEBREW_SHELLENV}'!"
  echo "Installed Homebrew successfully!"
fi

echo "Updating package index..."
brew update

echo "Installing packages..."
brew install \
  git stow curl wget zip gzip unzip make gnupg firefox \
  --cask ghostty tmux lm-sensors urlscan vim nvim \
  fzf fd ripgrep bat lazygit tree calc dos2unix --cask alt-tab \
  \
  python3 gcc cmake openjdk go \
  \
  --cask mactex biber \
  \
  --cask keepassxc --cask vlc pdftk-java ffmpeg graphviz plantuml

FDFIND="$(command -v fdfind)"
readonly FDFIND
if [[ -f "${FDFIND}" ]]; then
  echo "Linking 'fd' to 'fdfind'..."
  ln -svf "${FDFIND}" "${HOME}/.local/bin/fd"
fi

BATCAT="$(command -v batcat)"
readonly BATCAT
if [[ -f "${BATCAT}" ]]; then
  echo "Linking 'bat' to 'batcat'..."
  ln -svf "${BATCAT}" "${HOME}/.local/bin/bat"
fi

echo "Packages installed successfully!"
