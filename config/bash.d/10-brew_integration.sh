# brew_integration.sh: loads Homebrew shell integration.
#
# Must be loaded before all other shell integrations to ensure the relevant
# programs are added to the `PATH`.
#
# shellcheck shell=bash

# Opt out of analytics (see https://docs.brew.sh/Analytics).
export HOMEBREW_NO_ANALYTICS=1

# Add Homebrew `bin` to `PATH` if it exists.
[[ -d '/opt/homebrew/bin' ]] && PATH="/opt/homebrew/bin${PATH:+:${PATH}}"

# Load Homebrew shell environment.
command -v brew && eval "$(brew shellenv bash)"

# Enable Homebrew shell completion features.
[[ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] \
  && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
