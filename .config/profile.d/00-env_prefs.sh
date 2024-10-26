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

# Make `fzf` use `ripgrep` and match Vim bindings to accept / cancel.
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--bind=ctrl-o:accept,ctrl-e:abort'

# Export the JRE for apps that rely on `${JAVA_HOME}`.
export JAVA_HOME=$(readlink -e "/usr/bin/java" | sed "s:/bin/java::")

# Set if terminal is configured with a Nerd Font, unset otherwise.
export NERD_FONT_ENABLED="yes"

# Set colorscheme for terminal and CLI apps (`tmux`, `vim`, `nvim`).
export COLORSCHEME="sonokai"
