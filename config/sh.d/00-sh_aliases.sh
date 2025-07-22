# sh_aliases.sh: contains various aliases for interactive shells.
#
# shellcheck shell=sh

# Starts a `tmux` session for the current project, trying to find:
# - The root of the Git repository
# - The current working directory
tmxp() {
  _tmx_project_root="$(git rev-parse --show-toplevel)"
  [ -z "${_tmx_project_root}" ] && _tmx_project_root="${PWD}"
  tmx -s "$(basename "${_tmx_project_root}")"
}

# Open argument with the default program.
alias o='open > /dev/null 2>&1'

# Enable colors in `less`.
alias less='less -R'

# Alias `ls` to `lsd` and enable colored output.
alias ls='lsd --color=always'
alias la='lsd -A --color=always'
alias ll='lsd -alF --color=always'
alias lt='lsd --tree --color=always'

# Enable colored `fd` output, and show hidden files.
alias fd='fd --color=always --hidden'

# Enable colored `rg` output, and show hidden files.
alias rg='rg --color=always --hidden'

# Enable colored `grep` output.
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
