# env_xdg.sh: exports XDG environment variables.

# Configure XDG directories:
# - https://specifications.freedesktop.org/basedir-spec/latest/index.html
# - https://wiki.archlinux.org/title/XDG\_Base\_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Export `readline` config file.
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

# Export `ripgrep` config file.
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgreprc"

# Export `wget` config file.
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

# Export `nvm` directory.
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

# Export `npm` config file.
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# Export `calc` history file.
export CALCHISTFILE="${XDG_STATE_HOME}/calc_history"

# Export `python` history file.
export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"

# Export LaTeX directories.
export TEXMFHOME="${XDG_DATA_HOME}/texmf"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmf-var"
export TEXMFCONFIG="${XDG_CONFIG_HOME}/texlive/texmf-config"
export TEXMACS_HOME_PATH="${XDG_STATE_HOME}/texmacs"

# Export GnuPG directory.
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Export local Maven repository.
export MAVEN_OPTS="-Dmaven.repo.local='${XDG_DATA_HOME}/maven/repository'"

# Export directory for Gradle global config properties, caches, logs, etc.
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# Export Go path.
export GOPATH="${XDG_DATA_HOME}/go"