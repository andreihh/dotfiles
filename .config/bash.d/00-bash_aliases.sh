# bash_aliases.sh: contains various aliases for interactive shells.

# Open argument with the default program.
alias o='open &> /dev/null'

# Enable color support of `ls` and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors \
    && eval "$(dircolors -b ~/.dircolors)" \
    || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Some more `ls` aliases.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias tree='tree -C'
alias less='less -R'

# Colored GCC warnings and errors.
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Attach to the `work` `tmux` session, or create it if it doesn't exist.
alias tmuxw='tmux new -A -s work'
