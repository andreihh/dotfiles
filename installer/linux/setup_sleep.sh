#!/bin/bash -e

# Configures device sleep modes.

readonly SLEEP_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/sleep/sleep.conf"
readonly SLEEP_CONFIGS_DIR="/etc/systemd/sleep.conf.d"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Configuring device sleep modes..."

if [[ ! -f "${SLEEP_CONFIG}" ]]; then
  echo "Sleep config '${SLEEP_CONFIG}' does not exist!"
  exit 1
fi

echo "Ensuring the device sleep modes config directory exists..."
sudo mkdir -p "${SLEEP_CONFIGS_DIR}"

echo "Setting up device sleep modes config..."
sudo ln -sfv "${SLEEP_CONFIG}" "${SLEEP_CONFIGS_DIR}/00-sleep.conf"
echo "Configured device sleep modes successfully!"
