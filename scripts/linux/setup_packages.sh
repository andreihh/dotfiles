#!/bin/bash

# Installs various packages specific for Linux systems.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly PACKAGES=\
"git vim vim.gtk3 tmux xsel tree urlview wget curl zenity dos2unix "\
"tlp lm-sensors smartmontools linux-tools-common linux-tools-generic "\
"openjdk-18-jdk visualvm "\
"build-essential cmake "\
"python3 python3-dev pylint python-is-python3 "\
"texlive texlive-latex-extra texlive-science texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "\
"graphviz plantuml "\
"snapd firefox pdftk ffmpeg vlc keepassxc "

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating package index..."
sudo apt-get update || echoerr "Failed to update package index!"

echo "Installing required packages..."
for package in $PACKAGES; do
  echo "Installing package '$package'..."
  sudo apt-get install "$package" \
    || echoerr "Failed to install package '$package'!"
done

echo "Updating Snap packages..."
sudo snap refresh || echoerr "Failed to update Snap packages!"

echo "Installing IntelliJ IDEA CE..."
sudo snap install intellij-idea-community --classic \
  || echoerr "Failed to install IntelliJ IDEA CE!"

echo "Required packages installed!"
