# brew_integration.sh: loads Homebrew shell integration.
#
# shellcheck shell=bash

# Add Homebrew `bin` to `PATH` if it exists.
[[ -d '/opt/homebrew/bin' ]] && PATH="/opt/homebrew/bin${PATH:+:${PATH}}"

# Load Homebrew shell environment.
command -v brew && eval "$(brew shellenv bash)"

# Enable Homebrew shell completion features.
[[ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] \
  && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
