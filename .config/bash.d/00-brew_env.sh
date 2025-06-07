# brew_env.sh: loads Homebrew shell environment.
#
# shellcheck shell=bash

[[ -d '/opt/homebrew/bin' ]] && PATH="/opt/homebrew/bin${PATH:+:${PATH}}"
command -v brew && eval "$(brew shellenv bash)"
