#!/bin/sh
#
# Installs core packages.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

echo "Installing core packages..."

# Install common packages:
# - Core tools
# - TUI tools
# - CI and build tools
install-pkg \
  git stow wget curl zip gzip unzip tar gnupg fastfetch \
  alacritty bash tmux vim neovim fzf bat lsd fd-find ripgrep calc \
  pre-commit reuse make automake cmake

# Install specific Debian / Ubuntu packages:
has-cmd apt-get && install-pkg btm

# Install specific MacOS packages:
has-cmd brew && install-pkg bottom

# Alacritty requires a Nerd Font.
echo "Installing JetBrains Mono Nerd Font..."
if has-cmd brew; then
  brew install font-jetbrains-mono-nerd-font
else
  readonly FONTS_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/fonts"
  readonly FONT_ZIP='JetBrainsMono.zip'
  readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"

  mkdir -p "${FONTS_DIR}"
  cd "${FONTS_DIR}"
  wget "${FONT_URL}"
  unzip -o "${FONT_ZIP}"
  rm "${FONT_ZIP}"
  fc-cache -fv
fi

echo "Ensuring 'fdfind' and 'batcat' can be invoked as 'fd' and 'bat'..."
has-cmd fdfind && ln -sfv "$(command -v fdfind)" "${HOME}/.local/bin/fd"
has-cmd batcat && ln -sfv "$(command -v batcat)" "${HOME}/.local/bin/bat"

echo "Updating 'bat' cache..."
bat cache --build

if has-cmd update-alternatives; then
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
