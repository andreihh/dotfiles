#!/bin/bash -e
#
# Updates and installs required packages.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

if ! command -v brew &> /dev/null; then
  echo "Setting up Homebrew environment script..."
  export SHELL="/bin/sh"
  export ENV="${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d/00-brew.sh"
  touch "${ENV}"

  echo "Installing Homebrew..."
  # `curl` should be installed by default on MacOS.
  [[ -n "${debug}" ]] || /bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALLER})"
  echo "Installed Homebrew successfully!"

  # Reset environment variables.
  export SHELL="/bin/bash"
  unset ENV
fi

echo "Updating package index..."
brew update

echo "Installing packages..."
brew install \
  git stow curl wget zip gzip unzip make gnupg firefox \
  --cask iterm2 tmux lm-sensors reattach-to-user-namespace urlscan vim nvim \
  fzf fd ripgrep bat lazygit tree calc dos2unix \
  --cask font-jetbrains-mono-nerd-font --cask alt-tab \
  \
  python3 \
  gcc cmake \
  openjdk --cask intellij-idea-ce \
  go \
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