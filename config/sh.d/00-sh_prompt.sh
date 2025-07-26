# sh_prompt.sh: configures the shell prompt.
#
# The prompt is POSIX compliant (supports `bash`, `dash`, `ksh`, and `zsh`), but
# requires a Nerd Font.
#
# shellcheck shell=sh

# Returns if inside a VCS repository (supports `git`).
_ps1_has_vcs() {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

# Returns the current VCS branch and dirty status (supports `git`).
_ps1_vcs_branch() {
  _ps1_branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null \
    || git describe --all --exact-match HEAD 2> /dev/null \
    || git rev-parse --short HEAD 2> /dev/null \
    || printf '(unknown)')"

  _ps1_branch_dirty=''
  [ -n "$(git status --porcelain 2> /dev/null)" ] && _ps1_branch_dirty='*'

  printf '%s%s' "${_ps1_branch}" "${_ps1_branch_dirty}"
}

# Makes a custom prompt in the following format:
#   `chroot user at host on branch in dir $`
#
# The `chroot`, host, and branch are optional. Colors are used if supported.
_make_prompt() {
  # Configure style escape sequences (not required for `dash` and `ksh`).
  _esc1='' && _esc2=''
  [ -n "${BASH_VERSION}" ] && _esc1='\[' && _esc2='\]'
  [ -n "${ZSH_VERSION}" ] && _esc1='%{' && _esc2='%}' && setopt prompt_subst

  # If colors are supported, define styles and colors:
  # - Text: bold
  # - Shell: green
  # - Chroot: purple
  # - User: red
  # - Host: green
  # - VCS: yellow
  # - Current working directory: blue
  if [ "$(tput colors)" -ge 8 ]; then
    _reset_style="${_esc1}$(tput sgr0)${_esc2}"
    _text_style="${_esc1}$(tput sgr0 && tput bold)${_esc2}"
    _shell_style="${_esc1}$(tput sgr0 && tput bold && tput setaf 2)${_esc2}"
    _chroot_style="${_esc1}$(tput sgr0 && tput bold && tput setaf 5)${_esc2}"
    _user_style="${_esc1}$(tput sgr0 && tput bold && tput setaf 1)${_esc2}"
    _host_style="${_esc1}$(tput sgr0 && tput bold && tput setaf 2)${_esc2}"
    _vcs_style="${_esc1}$(tput sgr0 && tput bold && tput setaf 3)${_esc2}"
    _cwd_style="${_esc1}$(tput sgr0 && tput bold && tput setaf 4)${_esc2}"
  fi

  # Set `chroot` if detected (`nf-fa-folder_tree`).
  [ -r /etc/debian_chroot ] && _debian_chroot="$(cat /etc/debian_chroot)"
  PS1="${_debian_chroot:+${_chroot_style} ${_debian_chroot} }"

  # Set user (`nf-fa-user`).
  PS1="${PS1}${_user_style} ${USER}"

  # Set host only if the current session is remote (`nf-md-monitor`).
  if [ -n "${SSH_TTY}" ]; then
    PS1="${PS1}${_text_style} at ${_host_style}󰍹 $(uname -n | cut -d . -f 1)"
  fi

  # Set VCS branch if enabled and inside a repository (`nf-fa-code_branch`).
  PS1="${PS1}${_text_style}\$(_ps1_has_vcs && printf ' on ')"
  PS1="${PS1}${_vcs_style}\$(_ps1_has_vcs && printf ' ' && _ps1_vcs_branch)"

  # Set current working directory with `HOME` collapsed to `~` (`nf-fa-folder`).
  PS1="${PS1}${_text_style} in ${_cwd_style} \$(pwd | sed 's:^${HOME}:~:')"

  # Set shell on new line and reset style.
  PS1="${PS1}$(printf '\n%s ' "${_shell_style}\$${_reset_style}")"
  PS2="${_shell_style}> ${_reset_style}"
}

# Configure shell prompt.
_make_prompt
