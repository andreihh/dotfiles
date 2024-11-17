# nvm_completion.sh: loads `nvm` with completion.
#
# shellcheck shell=bash
# shellcheck source=/dev/null

[[ -s "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"
[[ -s "${NVM_DIR}/bash_completion" ]] && . "${NVM_DIR}/bash_completion"
