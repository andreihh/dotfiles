#!/bin/bash -e
#
# Installs `pyenv`.
#
# See https://github.com/pyenv/pyenv?tab=readme-ov-file#installation.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Requirements:
# - Linux: `curl`
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing 'pyenv' in root '${PYENV_ROOT:?}'..."

if command -v brew &> /dev/null; then
  brew install pyenv pyenv-virtualenv
else
  curl -fsSL https://pyenv.run | bash
fi

echo "Configuring 'pyenv' shell integration..."
cat << 'EOF' > "${XDG_CONFIG_HOME:?}/bash.d/00-pyenv_integration.sh"
# pyenv_integration.sh: loads `pyenv` shell integration.
#
# shellcheck shell=bash

[[ -n "${PYENV_ROOT}" && -d "${PYENV_ROOT}/bin" ]] \
  && export PATH="${PYENV_ROOT}/bin:${PATH}" \
  && eval "$(pyenv init - bash)" \
  && eval "$(pyenv virtualenv-init -)"
EOF

echo "Installed 'pyenv' successfully!"
