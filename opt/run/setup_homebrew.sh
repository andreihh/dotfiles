#!/bin/bash -e
#
# Installs Homebrew on MacOS systems.
#
# Requirements: `curl` (should be installed by default on MacOS)

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
readonly HOMEBREW_SHELLENV="${XDG_CONFIG_HOME:?}/profile.d/00-brew.sh"

echo "Installing Homebrew..."
if ! command -v brew &> /dev/null; then
  [[ -n "${debug}" ]] || /bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALLER})"
  echo "Installed Homebrew successfully!"

  echo "You must write the 'brew shellenv' output to '${HOMEBREW_SHELLENV}'!"
  echo "You must run 'brew install git stow'!"
else
  echo "Homebrew already installed!"

  echo "Installing 'git' and 'stow'..."
  brew install git stow
  echo "Installed 'git' and 'stow' successfully!"
fi
