#!/bin/bash -e
#
# Installs core packages.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing core packages..."

command -v apt-get &> /dev/null && sudo apt-get install -y \
  git stow wget curl zip gzip unzip tar gnupg \
  alacritty tmux lm-sensors urlscan vim fzf fd-find ripgrep bat lazygit calc \
  fastfetch btm keepassxc cava cmus vlc \
  make automake cmake build-essential pre-commit

command -v dnf &> /dev/null && sudo dnf install -y \
  git stow wget curl zip gzip unzip tar gnupg \
  alacritty tmux lm_sensors urlscan vim fzf fd-find ripgrep bat calc \
  fastfetch keepassxc cava vlc \
  make automake cmake gcc gcc-c++ pre-commit

command -v brew &> /dev/null && brew install \
  git stow wget curl zip gzip unzip tar gnupg \
  alacritty tmux lm-sensors urlscan vim fzf fd-find ripgrep bat lazygit calc \
  --cask font-jetbrains-mono-nerd-font \
  fastfetch bottom --cask keepassxc cava cmus --cask vlc \
  make automake cmake gcc pre-commit

if ! command -v brew &> /dev/null; then
  readonly FONT_ZIP='JetBrainsMono.zip'
  readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"

  # Nerd Font required for Alacritty.
  echo "Installing JetBrains Mono Nerd Font..."
  cd "${XDG_DATA_HOME:-${HOME}/.local/share}/fonts"
  wget "${FONT_URL}"
  unzip "${FONT_ZIP}"
  rm "${FONT_ZIP}"
  fc-cache -fv
fi

if command -v fdfind &> /dev/null; then
  echo "Linking 'fd' to 'fdfind'..."
  ln -sfv "$(command -v fdfind)" "${HOME}/.local/bin/fd"
fi

if command -v batcat &> /dev/null; then
  echo "Linking 'bat' to 'batcat'..."
  ln -sfv "$(command -v batcat)" "${HOME}/.local/bin/bat"

  echo "Updating 'batcat' cache..."
  batcat cache --build
elif command -v bat &> /dev/null; then
  echo "Updating 'bat' cache..."
  bat cache --build
fi

if command -v update-alternatives &> /dev/null; then
  echo "Configuring Alacritty as the default terminal..."
  ALACRITTY_BIN="$(command -v alacritty)"
  sudo update-alternatives --install \
    /usr/bin/x-terminal-emulator \
    x-terminal-emulator \
    "${ALACRITTY_BIN}" 100
  sudo update-alternatives --set x-terminal-emulator "${ALACRITTY_BIN}"
fi

echo "Changing default shell to Bash..."
chsh -s /bin/bash

echo "Installed core packages successfully!"
