#!/usr/bin/env bash

# Installs Linux dotfiles.
#
# Requires wget or curl.

readonly GH_ROOT="https://raw.githubusercontent.com/andreihh/.dotfiles/master"
readonly INSTALL_SCRIPT_URL="$GH_ROOT/scripts/install.sh"
readonly SCRIPTS_DIR="$HOME/.dotfiles/scripts"
readonly SCRIPTS=\
"$SCRIPTS_DIR/setup_dotfiles.sh "\
"$SCRIPTS_DIR/linux/setup_packages.sh "\
"$SCRIPTS_DIR/linux/setup_settings.sh " \
"$SCRIPTS_DIR/linux/setup_swappiness.sh "\
"$SCRIPTS_DIR/linux/setup_sleep.sh "\
"$SCRIPTS_DIR/linux/setup_tlp.sh "\
"$SCRIPTS_DIR/setup_tpm.sh "

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Downloading installer..."
wget "$GH_URL/scripts/install.sh" || curl -LO "$INSTALL_SCRIPT" || exit 1

echo -e "\nRunning installer..."
chmod +x ./install.sh && ./install.sh $SCRIPTS && rm ./install.sh || exit 1
