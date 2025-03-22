# env_xdg.sh: exports XDG environment variables.
#
# shellcheck shell=sh

# Configure XDG directories:
# - https://specifications.freedesktop.org/basedir-spec/latest/index.html
# - https://wiki.archlinux.org/title/XDG\_Base\_Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME-${HOME}/.local/state}"

# Export `readline` config file.
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

# Export `fzf` config file.
export FZF_DEFAULT_OPTS_FILE="${XDG_CONFIG_HOME}/fzf/fzfrc"

# Export `ripgrep` config file.
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgreprc"

# Export `wget` config file.
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

# Export `calc` history file.
export CALCHISTFILE="${XDG_STATE_HOME}/calc_history"

# Export GnuPG directory.
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Export `python` history file.
export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"

# Export `pyenv` directory.
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"

# Export LaTeX directories.
export TEXMFHOME="${XDG_DATA_HOME}/texmf"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmf-var"
export TEXMFCONFIG="${XDG_CONFIG_HOME}/texlive/texmf-config"
export TEXMACS_HOME_PATH="${XDG_STATE_HOME}/texmacs"

# Export Docker config directory.
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# Export the JRE for apps that rely on `${JAVA_HOME}`.
# shellcheck disable=SC2155
export JAVA_HOME="$(readlink -e '/usr/bin/java' | sed 's:/bin/java::')"

# Export Java user preferences location.
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot='${XDG_CONFIG_HOME}'/java"

# Export Maven local repository.
export MAVEN_OPTS="-Dmaven.repo.local='${XDG_DATA_HOME}/maven/repository'"

# Export Gradle directory for global config properties, caches, logs, etc.
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# Export `nvm` directory.
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

# Export `npm` config file.
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# Export Go modules directory.
export GOPATH="${XDG_DATA_HOME}/go"

# Export `rustup` toolchains and configs directory.
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# Export Cargo local registry.
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
