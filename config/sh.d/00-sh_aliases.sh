# sh_aliases.sh: contains various aliases for interactive shells.
#
# shellcheck shell=sh

# Selects `tmux` session.
alias t='tmx'

# Opens argument with the default program.
alias o='open > /dev/null 2>&1'

if command -v lsd > /dev/null 2>&1; then
  # Alias `ls` to `lsd` and enable icons and colored output.
  alias ls='lsd --color=always --icon=always'

  # Lists directory contents recursively as a tree.
  alias lt='ls --tree'
fi

# Setup common `ls` aliases.
alias l='ls -F'
alias la='ls -AF'
alias ll='ls -alF'

# Enable colors in `less`.
alias less='less -R'

# Enable colored `fd` output and show hidden files.
alias fd='fd --color=always --hidden'

# Enable colored `rg` output and show hidden files.
alias rg='rg --color=always --hidden'

# Enable colored `bat` output.
alias bat='bat --color=always'
