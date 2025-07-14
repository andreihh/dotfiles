# sh_prompt.sh: configures the shell prompt.
#
# The prompt is POSIX compliant: supports `bash`, `dash`, `ksh, and `zsh`.
#
# Requires a Nerd Font.
#
# shellcheck shell=sh

# Command used to display the current working directory in the prompt:
# - Defaults to `prompt_cwd`
# - If unset, falls back to `pwd`
# - Override to transform paths
PROMPT_COMMAND_CWD='prompt_cwd'

# Commands used to detect the current VCS branch to be included in the prompt:
# - Defaults are `prompt_git_enabled` and `prompt_git_branch`
# - Unset to drop VCS info from the prompt
# - Override to support other systems besides `git`
PROMPT_COMMAND_VCS_ENABLED='prompt_git_enabled'
PROMPT_COMMAND_VCS_BRANCH='prompt_git_branch'

# Returns the current working directory, collapsing `HOME` to `~`.
prompt_cwd() {
  pwd | sed "s:^${HOME}:~:"
}

# Returns if a `git` repository is detected.
prompt_git_enabled() {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1 || return 1
}

# Returns the current `git` branch and dirty status (`nf-fa-code_branch`).
prompt_git_branch() {
  prompt_git_enabled || return 1

  _prompt_branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null \
    || git describe --all --exact-match HEAD 2> /dev/null \
    || git rev-parse --short HEAD 2> /dev/null \
    || echo '(unknown)')"

  _prompt_branch_dirty=''
  if [ -n "$(git status --porcelain 2> /dev/null)" ]; then
    _prompt_branch_dirty='*'
  fi

  echo " ${_prompt_branch}${_prompt_branch_dirty}"
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

  # Set the `chroot` you work in, if any (`nf-fa-folder_tree`).
  [ -r /etc/debian_chroot ] && _debian_chroot="$(cat /etc/debian_chroot)"
  PS1="${_debian_chroot:+${_chroot_style} ${_debian_chroot} }"

  # Set current user (`nf-fa-user`).
  PS1="${PS1}${_user_style} ${USER}"

  # Set the host only if the current session is remote (`nf-md-monitor`).
  if [ -n "${SSH_TTY}" ]; then
    PS1="${PS1}${_text_style} at ${_host_style}󰍹 $(uname -n)"
  fi

  # Set current VCS branch if VCS info is enabled and repository is detected.
  PS1="${PS1}${_text_style}\$(\${PROMPT_COMMAND_VCS_ENABLED} && echo ' on ')"
  PS1="${PS1}${_vcs_style}\$(\${PROMPT_COMMAND_VCS_BRANCH})"

  # Set current working directory (`nf-fa-folder`).
  PS1="${PS1}${_text_style} in ${_cwd_style} \$(\${PROMPT_COMMAND_CWD:-pwd})"

  # Set shell on new line and reset style.
  PS1="${PS1}$(printf '\n%s ' "${_shell_style}\$${_reset_style}")"
  PS2="${_shell_style}> ${_reset_style}"
}

# Configure custom shell prompt.
_make_prompt
