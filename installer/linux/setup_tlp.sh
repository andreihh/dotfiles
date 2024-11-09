#!/bin/bash -e
#
# Configures TLP.

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly TLP_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/tlp/tlp.conf"
readonly TLP_CONFIGS_DIR="/etc/tlp.d"

echo "Configuring TLP..."

if [[ ! -f "${TLP_CONFIG}" ]]; then
  echo "TLP config '${TLP_CONFIG}' does not exist!"
  exit 1
fi

if [[ ! -d "${TLP_CONFIGS_DIR}" ]]; then
  echo "TLP configs directory '${TLP_CONFIGS_DIR}' does not exist!"
  exit 1
fi

echo "Setting up TLP config..."
sudo ln -sfv "${TLP_CONFIG}" "${TLP_CONFIGS_DIR}/00-tlp.conf"

echo "Starting up TLP service..."
sudo systemctl enable tlp.service
sudo tlp start

echo "Configured TLP successfully!"
