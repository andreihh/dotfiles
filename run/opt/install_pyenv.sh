#!/bin/sh
#
# Installs `pyenv`.
#
# See https://github.com/pyenv/pyenv#installation.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - Linux: `curl`
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly PYENV_ROOT="${PYENV_ROOT:-${XDG_DATA_HOME}/pyenv}"

echo "Installing 'pyenv' in '${PYENV_ROOT}'..."
if has-cmd brew; then
  brew install pyenv pyenv-virtualenv
else
  curl -fsSL https://pyenv.run | bash
fi

echo "Configuring 'pyenv' shell integration..."
cat << 'EOF' > "${XDG_CONFIG_HOME}/bash.d/20-pyenv_integration.sh"
# pyenv_integration.sh: loads `pyenv` shell integration.
#
# shellcheck shell=bash

[[ -n "${PYENV_ROOT}" && -d "${PYENV_ROOT}/bin" ]] \
  && PATH="${PYENV_ROOT}/bin${PATH:+:${PATH}}" \
  && eval "$(pyenv init - bash)" \
  && eval "$(pyenv virtualenv-init -)"
EOF

echo "Installed 'pyenv' successfully!"
