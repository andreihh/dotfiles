#!/usr/bin/env bash

# Installs various packages specific for Linux systems.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly PACKAGES=\
"git vim vim.gtk3 tmux xsel tree urlview wget curl zenity "\
"tlp lm-sensors smartmontools linux-tools-common linux-tools-generic "\
"openjdk-18-jdk visualvm "\
"build-essential cmake "\
"python3 python3-dev pylint python-is-python3 "\
"texlive texlive-latex-extra texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "\
"graphviz plantuml "\
"snapd firefox ffmpeg vlc keepassxc "

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating package index..."
sudo apt-get update \
  && echo "Package index updated!" \
  || echoerr "Failed to update package index!"

echo -e "\nInstalling required packages..."
for package in $PACKAGES; do
  echo "Installing package '$package'..."
  sudo apt-get install "$package" \
    && echo "Package '$package' installed!" \
    || echoerr "Failed to install package '$package'!"
done

echo -e "\nInstalling IntelliJ IDEA CE"
sudo snap install intellij-idea-community --classic \
  && echo "IntelliJ IDEA CE installed!" \
  || echoerr "Failed to install IntelliJ IDEA CE!"

echo -e "\nRequired packages installed!"
