#!/bin/bash

# Installs various packages specific for Linux systems.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly PACKAGES=\
"firefox git vim tmux lm-sensors tree urlview wget curl dos2unix "\
"snapd vim.gtk3 xsel zenity tlp linux-tools-common linux-tools-generic "\
"openjdk-18-jdk visualvm "\
"python3 python3-dev python-is-python3 pylint "\
"build-essential cmake "\
"texlive texlive-latex-extra texlive-science texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "\
"keepassxc pdftk ffmpeg vlc graphviz plantuml "

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
