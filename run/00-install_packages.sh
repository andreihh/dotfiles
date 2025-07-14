#!/bin/sh
#
# Installs core packages.
#
# Ensures all core dependencies (e.g., for building Neovim) are installed.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

echo "Installing core packages..."
if command -v apt-get > /dev/null 2>&1; then
  _install_pkg() { sudo apt-get install -y "$@"; }
  # Install specific Debian / Ubuntu packages:
  _install_pkg lm-sensors btm build-essential ninja-build gettext cmus
fi

if command -v dnf > /dev/null 2>&1; then
  _install_pkg() { sudo dnf install -y "$@"; }
  # Install specific Fedora / RHEL packages:
  _install_pkg lm_sensors gcc gcc-c++ ninja-build gettext glibc-gconv-extra
fi

if command -v brew > /dev/null 2>&1; then
  _install_pkg() { brew install "$@"; }
  # Install specific MacOS packages:
  _install_pkg lm-sensors bottom gcc cmus font-jetbrains-mono-nerd-font
fi

# Install common packages:
# - Core tools
# - TUI tools
# - CI and build tools
# - General and media tools
_install_pkg \
  firefox git stow wget curl zip gzip unzip tar gnupg restic rclone \
  alacritty tmux urlscan vim fzf fd-find ripgrep bat calc fastfetch \
  pre-commit reuse make automake cmake \
  keepassxc cava vlc

if ! command -v brew > /dev/null 2>&1; then
  readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
  readonly FONT_ZIP='JetBrainsMono.zip'
  readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"

  # Alacritty requires a Nerd Font.
  echo "Installing JetBrains Mono Nerd Font..."
  mkdir -p "${XDG_DATA_HOME}/fonts"
  cd "${XDG_DATA_HOME}/fonts"
  wget "${FONT_URL}"
  unzip -o "${FONT_ZIP}"
  rm "${FONT_ZIP}"
  fc-cache -fv
fi

if command -v fdfind > /dev/null 2>&1; then
  echo "Linking 'fd' to 'fdfind'..."
  ln -sfv "$(command -v fdfind)" "${HOME}/.local/bin/fd"
fi

if command -v batcat > /dev/null 2>&1; then
  echo "Linking 'bat' to 'batcat'..."
  ln -sfv "$(command -v batcat)" "${HOME}/.local/bin/bat"

  echo "Updating 'batcat' cache..."
  batcat cache --build
elif command -v bat > /dev/null 2>&1; then
  echo "Updating 'bat' cache..."
  bat cache --build
fi

if command -v update-alternatives > /dev/null 2>&1; then
  echo "Configuring Alacritty as the default terminal..."
  alacritty_bin="$(command -v alacritty)"
  sudo update-alternatives --install \
    /usr/bin/x-terminal-emulator \
    x-terminal-emulator \
    "${alacritty_bin}" 100
  sudo update-alternatives --set x-terminal-emulator "${alacritty_bin}"
fi

echo "Configuring Bash as the default shell..."
chsh -s /bin/bash || echo "Failed to change default shell, set it manually!"

echo "Installed core packages successfully!"
