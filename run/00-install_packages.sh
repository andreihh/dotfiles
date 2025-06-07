#!/bin/bash -e
#
# Installs core packages.
#
# Ensures all core dependencies (e.g., Neovim and Catppuccin) are installed.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing core packages..."
readonly COMMON_PKGS=(
  git stow wget curl zip gzip unzip tar gnupg  # Core tools
  alacritty tmux urlscan vim fzf fd-find ripgrep bat calc fastfetch  # TUI tools
  make automake cmake pre-commit  # Build tools
  keepassxc cava vlc  # General and media tools
)

command -v apt-get &> /dev/null && sudo apt-get install -y \
  "${COMMON_PKGS[@]}" \
  lm-sensors btm build-essential ninja-build gettext cmus

command -v dnf &> /dev/null && sudo dnf install -y \
  "${COMMON_PKGS[@]}" \
  lm_sensors gcc gcc-c++ ninja-build gettext glibc-gconv-extra

command -v brew &> /dev/null && brew install \
  "${COMMON_PKGS[@]}" \
  lm-sensors bottom gcc cmus font-jetbrains-mono-nerd-font

if ! command -v brew &> /dev/null; then
  readonly FONT_ZIP='JetBrainsMono.zip'
  readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"

  # Nerd Font required for Alacritty.
  echo "Installing JetBrains Mono Nerd Font..."
  cd "${XDG_DATA_HOME:-${HOME}/.local/share}/fonts"
  wget "${FONT_URL}"
  unzip -o "${FONT_ZIP}"
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

echo "Installed core packages successfully!"
