#!/bin/sh
#
# Installs the Rust toolchain.
#
# See https://www.rust-lang.org/tools/install.
#
# Supported systems: *nix
# Dependencies: `curl`

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly RUSTUP_HOME="${RUSTUP_HOME:-${XDG_DATA_HOME}/rustup}"
readonly CARGO_HOME="${CARGO_HOME:-${XDG_DATA_HOME}/cargo}"

echo "Installing 'rustup' in '${RUSTUP_HOME}' and 'cargo' in '${CARGO_HOME}'..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Configuring 'cargo' shell integration..."
cat << 'EOF' > "${XDG_CONFIG_HOME}/sh.d/20-cargo_integration.sh"
# cargo_integration.sh: loads `cargo` shell integration.
#
# shellcheck shell=sh

[ -s "${CARGO_HOME}/env" ] && . "${CARGO_HOME}/env"
EOF

echo "Installed 'rustup' successfully!"
