#!/usr/bin/env bash

# This script will install various packages and perform customizations (e.g.,
# keyboard options) specific for Linux systems.

readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly PACKAGES=\
"linux-tools-common util-linux tlp lm-sensors smartmontools stress-ng "\
"vim git "\
"openjdk-18-jdk visualvm "\
"build-essential cmake "\
"python3 python3-dev pylint3 python-is-python3 "\
"texlive texlive-latex-extra texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "\
"graphviz plantuml "\
"zenity ffmpeg vlc keepassxc "

readonly TLP_UPDATER="$DOTFILES_DIR/linux/update_tlp.sh"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Sourcing essential bash aliases..."
. "$DOTFILES_DIR/.bash_aliases" || exit 1

echo -e "\nUpdating package index..."
sudo add-apt-repository ppa:linrunner/tlp \
  && sudo apt-get update \
  && echo "Package index updated!" \
  || echoerr "Failed to update package index!"

echo -e "\nInstalling required packages..."
for package in $packages; do
  echo "Installing package '$package'..."
  sudo apt-get install "$package" \
    && echo "Package '$package' installed!" \
    || echoerr "Failed to install package '$package'!"
done

echo -e "\nSetting keyboard layout to US, with RO alternative..."
gsettings set org.gnome.desktop.input-sources sources \
  "[('xkb', 'us'), ('xkb', 'ro+std')]" \
  && echo "Keyboard layouts updated!" \
  || echoerr "Failed to update keyboard layouts!"

echo -e "\nSwapping Caps Lock and Esc keys..."
gsettings set org.gnome.desktop.input-sources xkb-options \
  "['caps:swapescape']" \
  && echo "Caps Lock and Esc keys swapped!" \
  || echoerr "Failed to swap Caps Lock and Esc keys!"

echo -e "\nMaking hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop \
  && echo "All startup applications are visible!" \
  || echoerr "Failed to change visibility of hidden startup applications!"

echo -e "\nUpdating TLP config..."
$TLP_UPDATER \
  && echo "TLP configured successfully!" \
  || echoerr "Failed to configure TLP!"

echo -e "\nLinux setup done!"
