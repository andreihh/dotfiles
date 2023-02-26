#!/usr/bin/env bash

# This script will install various packages and perform customizations (e.g.,
# keyboard options) specific for Linux systems.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

# Prints the given message in red.
function echoerr() {
  echo -e "\033[0;31m${1}\033[0m"
}

packages=\
"linux-tools-common util-linux tlp lm-sensors smartmontools stress-ng "\
"vim git "\
"openjdk-18-jdk visualvm "\
"build-essential cmake "\
"python3 python3-dev pylint3 python-is-python3 "\
"texlive texlive-latex-extra texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "\
"graphviz plantuml "\
"zenity ffmpeg vlc keepassxc "


echo -e "\nUpdating package index..."
sudo add-apt-repository ppa:linrunner/tlp \
  && sudo apt-get update \
  && echo "Package index updated!" \
  || echorr "Failed to update package index!"

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

echo -e "\nConfiguring TLP settings..."
TLP_CONFIG=$(sudo tlp stat | grep "Configured Settings:" | sed 's/.*: //')

# Configures the given TLP option with the given value.
function set_tlp_option() {
  local option="$1"
  local value="$2"
  sudo sed -i -E "s/#?${option}=.*/${option}=${value}/" "$TLP_CONFIG"
}

[[ ! -z "$TLP_CONFIG" && -f "$TLP_CONFIG" ]] \
  && set_tlp_option "START_CHARGE_THRESH_BAT0" "70" \
  && set_tlp_option "STOP_CHARGE_THRESH_BAT0" "80" \
  && set_tlp_option "CPU_SCALING_GOVERNOR_ON_AC" "powersave" \
  && set_tlp_option "CPU_SCALING_GOVERNOR_ON_BAT" "powersave" \
  && set_tlp_option "CPU_MAX_PERF_ON_AC" "80" \
  && set_tlp_option "CPU_MAX_PERF_ON_BAT" "60" \
  && set_tlp_option "CPU_BOOST_ON_AC" "1" \
  && set_tlp_option "CPU_BOOST_ON_BAT" "0" \
  && sudo systemctl enable tlp.service \
  && echo "TLP configured successfully!" \
  || echoerr "Failed to configure TLP!"

echo -e "\nMaking hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop \
  && echo "All startup applications are visible!" \
  || echoerr "Failed to change visibility of hidden startup applications!"
