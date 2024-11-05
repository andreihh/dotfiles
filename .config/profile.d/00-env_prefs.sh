# env_prefs.sh: exports preferences as environment variables.

# Prefer Bash as shell.
export SHELL='/bin/bash'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Make Neovim the default editor.
export EDITOR='nvim'

# Make Firefox the default browser.
export BROWSER='firefox'

# Set if terminal is configured with a Nerd Font, unset otherwise.
export NERD_FONT_ENABLED="yes"

# Set colorscheme for terminal and CLI apps (`tmux`, `vim`, `nvim`).
export COLORSCHEME="sonokai"

# Export the JRE for apps that rely on `${JAVA_HOME}`.
# shellcheck disable=SC2155
export JAVA_HOME=$(readlink -e "/usr/bin/java" | sed "s:/bin/java::")
