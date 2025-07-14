# bash_prompt.sh: configures the shell prompt.
#
# Requires a Nerd Font.
#
# shellcheck shell=bash

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

# Returns the current `git` branch and dirty status.
prompt_git_branch() {
  prompt_git_enabled || return 1

  local -r branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null \
    || git describe --all --exact-match HEAD 2> /dev/null \
    || git rev-parse --short HEAD 2> /dev/null \
    || echo '(unknown)')"

  local dirty=''
  if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    dirty='*'
  fi

  echo " ${branch}${dirty}"  # `nf-fa-code_branch
}

# Makes a custom prompt in the following format:
#   `(chroot) user at host on branch in dir $`
#
# The `chroot`, host, and branch are optional. Colors are used if supported.
_make_prompt() {
  # If colors are supported, define styles and colors:
  # - Text: bold
  # - Shell: green
  # - Chroot: purple
  # - User: red
  # - Host: green
  # - VCS: yellow
  # - Current working directory: blue
  if [[ "$(tput colors)" -ge 8 ]]; then
    local -r reset_style="\[$(tput sgr0)\]"
    local -r text_style="\[$(tput sgr0 && tput bold)\]"
    local -r shell_style="\[$(tput sgr0 && tput bold && tput setaf 2)\]"
    local -r chroot_style="\[$(tput sgr0 && tput bold && tput setaf 5)\]"
    local -r user_style="\[$(tput sgr0 && tput bold && tput setaf 1)\]"
    local -r host_style="\[$(tput sgr0 && tput bold && tput setaf 2)\]"
    local -r vcs_style="\[$(tput sgr0 && tput bold && tput setaf 3)\]"
    local -r cwd_style="\[$(tput sgr0 && tput bold && tput setaf 4)\]"
  fi

  # Set variable identifying the `chroot` you work in.
  if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot="$(cat /etc/debian_chroot)"
  fi

  # Set the `chroot`, if any.
  PS1="${debian_chroot:+${chroot_style}(${debian_chroot}) }"

  # Set current user (`nf-fa-user`).
  PS1="${PS1}${user_style} ${USER}"

  # Set the host only if the current session is remote (`nf-md-monitor`).
  if [[ -n "${SSH_TTY}" ]]; then
    PS1="${PS1}${text_style} at ${host_style}󰍹 $(uname -n)"
  fi

  # Set current VCS branch if VCS info is enabled and repository is detected.
  PS1="${PS1}${text_style}\$(\${PROMPT_COMMAND_VCS_ENABLED} && echo ' on ')"
  PS1="${PS1}${vcs_style}\$(\${PROMPT_COMMAND_VCS_BRANCH})"

  # Set current working directory (`nf-fa-folder`).
  PS1="${PS1}${text_style} in ${cwd_style} \$(\${PROMPT_COMMAND_CWD:-pwd})"

  # Set shell on new line and reset style.
  PS1="${PS1}$(printf '\n%s ' "${shell_style}\$${reset_style}")"
  PS2="${shell_style}> ${reset_style}"

  # If this is an `xterm`, set the title to `user@host:dir`.
  case "${TERM}" in
    xterm* | rxvt*)
      PS1="\[\e]0;${debian_chroot:+(${debian_chroot})}\u@\h:\W\a\]${PS1}"
      ;;
    *) ;;
  esac
}

_make_prompt  # Configure custom prompt
