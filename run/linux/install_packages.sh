#!/bin/bash -e
#
# Installs required packages. Must run before all other scripts.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating package index..."
sudo apt update -y

echo "Installing packages..."
sudo apt install -y \
  firefox git stow curl wget zip gzip unzip tar make gnupg \
  tmux lm-sensors urlscan vim \
  fd-find ripgrep bat tree calc dos2unix \
  tlp linux-tools-common linux-tools-generic \
  \
  python3 build-essential cmake \
  \
  texlive texlive-latex-extra texlive-science texlive-fonts-extra latexmk \
  texlive-bibtex-extra biber \
  \
  keepassxc vlc pdftk-java ffmpeg graphviz plantuml

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
