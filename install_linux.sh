#!/usr/bin/env bash

# Installs Linux dotfiles.
#
# Requires wget or curl.

readonly GH_ROOT="https://raw.githubusercontent.com/andreihh/.dotfiles/master"
readonly INSTALLER="install.sh"
readonly SCRIPTS_DIR="$HOME/.dotfiles/scripts"
readonly BACKUP_SCRIPT="$SCRIPTS_DIR/backup.sh"
readonly SCRIPTS=\
"$SCRIPTS_DIR/setup_dotfiles.sh "\
"$SCRIPTS_DIR/linux/setup_packages.sh "\
"$SCRIPTS_DIR/linux/setup_settings.sh "\
"$SCRIPTS_DIR/linux/setup_swappiness.sh "\
"$SCRIPTS_DIR/linux/setup_sleep.sh "\
"$SCRIPTS_DIR/linux/setup_tlp.sh "\
"$SCRIPTS_DIR/setup_tpm.sh "

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Downloading installer..."
wget "$GH_ROOT/$INSTALLER" || curl -LO "$GH_ROOT/$INSTALLER" || exit 1

echo -e "\nRunning installer..."
chmod +x "$INSTALLER" \
  && ./"$INSTALLER" "$BACKUP_SCRIPT" $SCRIPTS \
  && rm "$INSTALLER" \
  || exit 1
