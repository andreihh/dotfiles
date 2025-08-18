#!/bin/sh
#
# Installs core packages.
#
# Supported systems: Debian*, Fedora*, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

echo "Installing core packages..."

# Install common packages:
# - Core tools
# - TUI tools
# - CI and build tools
install-pkg \
  git stow wget curl zip gzip unzip tar gnupg fastfetch \
  alacritty bash tmux vim neovim fzf bat lsd fd-find ripgrep calc \
  pre-commit reuse make automake cmake

# Install XDG packages on non-MacOS.
! has-cmd brew && install-pkg xdg-utils xdg-user-dirs xdg-terminal-exec

# Install specific Debian* packages:
has-cmd apt-get && install-pkg btm

# Install specific MacOS packages:
has-cmd brew && install-pkg bottom

echo "Linking 'open', 'fd', and 'bat' to 'xdg-open', 'fdfind', and 'batcat'..."
has-cmd xdg-open && ln -sfv "$(command -v xdg-open)" "${HOME}/.local/bin/open"
has-cmd fdfind && ln -sfv "$(command -v fdfind)" "${HOME}/.local/bin/fd"
has-cmd batcat && ln -sfv "$(command -v batcat)" "${HOME}/.local/bin/bat"

echo "Updating 'bat' cache..."
bat cache --build

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

echo "Configuring Alacritty as the default XDG terminal..."
rm "${XDG_CONFIG_HOME}"/*-xdg-terminals.list
echo 'Alacritty.desktop' > "${XDG_CONFIG_HOME}/xdg-terminals.list"

echo "Configuring Bash as the default shell..."
chsh -s /bin/bash || echo "Failed to change default shell, set it manually!"

echo "Installed core packages successfully!"
