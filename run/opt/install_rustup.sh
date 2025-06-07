#!/bin/bash -e
#
# Installs the Rust toolchain.
#
# See https://www.rust-lang.org/tools/install.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Requirements: `curl`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'rustup'..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "Installed 'rustup' successfully!"
