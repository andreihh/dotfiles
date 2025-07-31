# sh_aliases.sh: contains various aliases for interactive shells.
#
# shellcheck shell=sh

# Open argument with the default program.
alias o='open > /dev/null 2>&1'

# Enable colors in `less`.
alias less='less -R'

# Alias `ls` to `lsd` and enable icons and colored output.
alias ls='lsd --color=always --icon=always'
alias la='lsd -A --color=always --icon=always'
alias ll='lsd -alF --color=always --icon=always'
alias lt='lsd --tree --color=always --icon=always'

# Enable colored `fd` output and show hidden files.
alias fd='fd --color=always --hidden'

# Enable colored `rg` output and show hidden files.
alias rg='rg --color=always --hidden'

# Enable colored `grep` output.
alias grep='grep --color=always'

# Enable colored `bat` output.
alias bat='bat --color=always'
