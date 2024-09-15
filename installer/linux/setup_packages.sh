#!/bin/bash

# Installs various packages specific for Linux systems.

. "$HOME/.dotfiles/scripts/utils.sh" || exit 1

readonly LINUX_CORE_PACKAGES=\
"snapd vim.gtk3 xsel xclip silversearcher-ag zenity tlp "
"linux-tools-common linux-tools-generic "

readonly LATEX_PACKAGES=\
"texlive texlive-latex-extra texlive-science texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "

readonly DEVELOPMENT_PACKAGES=\
"python3 python-is-python3 "\
"openjdk-18-jdk visualvm "\
"build-essential cmake "

readonly MEDIA_PACKAGES=\
"keepassxc pdftk ffmpeg vlc graphviz plantuml "

readonly PACKAGES=\
"$CORE_PACKAGES "\
"$LINUX_CORE_PACKAGES "\
"$LATEX_PACKAGES "\
"$DEVELOPMENT_PACKAGES "\
"$MEDIA_PACKAGES "

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Updating package index..."
sudo apt-get update || echoerr "Failed to update package index!"

echo "Installing required packages..."
install_packages "sudo apt-get -y install" $PACKAGES

echo "Updating Snap packages..."
sudo snap refresh || echoerr "Failed to update Snap packages!"

echo "Installing Snap packages..."
install packages "sudo snap install" intellij-idea-community --classic

# See headless installation instructions on https://dropbox.com/install-linux.
echo "Installing Dropbox..."
readonly DROPBOX="https://www.dropbox.com/download?plat=lnx.x86_64"
cd ~ && wget -O - "$DROPBOX" | tar xzf - \
  && ~/.dropbox-dist/dropboxd \
  || echoerr "Failed to install Dropbox!"

echo "Packages installed!"
