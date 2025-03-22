# env_prefs.sh: exports preferences as environment variables.
#
# shellcheck shell=sh

# Use US English and UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Make Bash the default shell.
export SHELL="${SHELL-/bin/bash}"

# Make Neovim the default editor.
export EDITOR="${EDITOR-nvim}"

# Make Firefox the default browser.
export BROWSER="${BROWSER-firefox}"
