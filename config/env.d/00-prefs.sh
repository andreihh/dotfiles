# prefs.sh: exports preferences as environment variables.
#
# shellcheck shell=sh

# Configure locale to:
# - US English
# - ISO 8601 date and time
# - A4 paper size
# - Metric system
export LANG='en_US.UTF-8'
export LC_TIME=en_DK.UTF-8
export LC_PAPER='en_GB.UTF-8'
export LC_MEASUREMENT='en_GB.UTF-8'

# Configure default programs.
export SHELL='/bin/bash'
export EDITOR='nvim'
export BROWSER='firefox'
