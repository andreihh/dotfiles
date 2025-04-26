# cargo_integration.sh: loads `cargo` shell integration.
#
# shellcheck shell=bash
# shellcheck source=/dev/null

[[ -s "${CARGO_HOME}/env" ]] && . "${CARGO_HOME}/env"
