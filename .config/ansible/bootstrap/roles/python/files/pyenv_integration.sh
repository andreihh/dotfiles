# pyenv_integration.sh: loads `pyenv` shell integration.
#
# shellcheck shell=bash

[[ -d "${PYENV_ROOT}/bin" ]] \
  && export PATH="${PYENV_ROOT}/bin:${PATH}" \
  && eval "$(pyenv init - bash)" \
  && eval "$(pyenv virtualenv-init -)"
