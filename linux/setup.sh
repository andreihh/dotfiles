#!/usr/bin/env bash

# Installs various packages and performs customizations (e.g., keyboard options)
# specific for Linux systems.

readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly PACKAGES=\
"tlp lm-sensors smartmontools linux-tools-common linux-tools-generic "\
"vim git tmux curl zenity "\
"openjdk-18-jdk visualvm "\
"build-essential cmake "\
"python3 python3-dev pylint python-is-python3 "\
"texlive texlive-latex-extra texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "\
"graphviz plantuml "\
"firefox ffmpeg vlc keepassxc "

readonly SYSCTL_CONFIG="/etc/sysctl.conf"
readonly SLEEP_CONFIG="$DOTFILES_DIR/linux/sleep.conf"
readonly SLEEP_CONFIGS_DIR="/etc/systemd/sleep.conf.d"
readonly TLP_CONFIG="$DOTFILES_DIR/linux/tlp.conf"
readonly TLP_CONFIGS_DIR="/etc/tlp.d"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Starting Linux setup..."

echo -e "\nSourcing essential bash aliases..."
. "$DOTFILES_DIR/.bash_aliases" || exit 1

echo -e "\nUpdating package index..."
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

echo -e "\eRemoving Alt-Esc system key mapping..."
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "[]" \
  && echo "Alt-Esc key mapping removed!" \
  || echoerr "Failed to remove Alt-Esc key mapping!"

echo -e "\nSetting system theme to dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' \
  && echo "Dark mode enabled!" \
  || echoerr "Failed to set dark mode!"

echo -e "\nMaking hidden startup applications visible..."
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop \
  && echo "All startup applications are visible!" \
  || echoerr "Failed to change visibility of hidden startup applications!"

echo -e "\nSetting swappiness to 1..."
if grep -Ex "#?vm.swappiness=.*" "$SYSCTL_CONFIG"; then
  sudo sed -i -E "s/#?vm.swappiness=.*/vm.swappiness=1/" "$SYSCTL_CONFIG" \
    && sudo sysctl -p \
    && echo "Swappiness updated to 1 successfully!" \
    || echoerr "Failed to update swappiness to 1!"
else
  echo "vm.swappiness=1" | sudo tee -a "$SYSCTL_CONFIG" \
    && sudo sysctl -p \
    && echo "Swappiness set to 1 successfully!" \
    || echoerr "Failed to set swappiness to 1!"
fi

echo -e "\nConfiguring device sleep modes..."
[[ -f "$SLEEP_CONFIG" ]] \
  && sudo mkdir -p "$SLEEP_CONFIGS_DIR" \
  && sudo ln -sf "$SLEEP_CONFIG" "$SLEEP_CONFIGS_DIR/00-sleep.conf" \
  && echo "Device sleep modes configured successfully!" \
  || echoerr "Failed to configure device sleep modes!"

echo -e "\nConfiguring TLP..."
[[ -d "$TLP_CONFIGS_DIR" && -f "$TLP_CONFIG" ]] \
  && sudo ln -sf "$TLP_CONFIG" "$TLP_CONFIGS_DIR/00-tlp.conf" \
  && sudo systemctl enable tlp.service \
  && sudo tlp start \
  && echo "TLP configured successfully!" \
  || echoerr "Failed to configure TLP!"

echo -e "\nLinux setup completed!"
