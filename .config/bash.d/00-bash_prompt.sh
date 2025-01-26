# bash_prompt.sh: configures the shell prompt.
#
# Requires a Nerd Font.
#
# shellcheck shell=bash

# Command used to detect the current VCS branch to be included in the prompt:
# - Default is `__vcs_branch`
# - Unset to drop VCS info from the prompt
# - Set to custom function to work with other systems
export VCS_BRANCH_PROMPT_COMMAND="__vcs_branch"

# Returns the current `git` branch and dirty status.
__git_branch() {
  git rev-parse --is-inside-work-tree &> /dev/null || return 1

  local -r branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null \
    || git describe --all --exact-match HEAD 2> /dev/null \
    || git rev-parse --short HEAD 2> /dev/null \
    || echo '(unknown)')"

  local dirty=""
  if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
    dirty="*"
  fi

  echo " ${branch}${dirty}"  # `nf-fa-code_branch
}

# Returns the branch name and optionally dirty status of the current VCS branch.
#
# Supports `git`.
__vcs_branch() {
  __git_branch
}

# Makes a custom, dynamic prompt in the following format:
#   `(chroot) user at host on branch in dir $`
#
# The `chroot`, host and branch are optional. Colors are used if supported.
__make_prompt() {
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
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # Set the terminal prompt.
  PS1="${debian_chroot:+${chroot_style}(${debian_chroot}) }"  # Set `chroot`
  PS1+="${user_style} \u"  # Set current user, `nf-fa-user`

  # Set the host only if the current session is remote.
  if [[ -n "${SSH_TTY}" ]]; then
    PS1+="${text_style} at ${host_style}󰍹 \h"  # `nf-md-monitor`
  fi

  # Set current VCS branch if VCS info is enabled and repository is detected.
  if [[ -n "${VCS_BRANCH_PROMPT_COMMAND}" ]]; then
    local -r branch="$(${VCS_BRANCH_PROMPT_COMMAND})"
    if [[ -n "${branch}" ]]; then
      PS1+="${text_style} on ${vcs_style}${branch}"
    fi
  fi

  PS1+="${text_style} in ${cwd_style} \w"  # Set `cwd`, `nf-fa-folder`
  PS1+="\n${shell_style}\$ ${reset_style}"  # Set shell and reset style

  PS2="${shell_style}> ${reset_style}"  # Set shell and reset style

  # If this is an `xterm`, set the title to `user@host:dir`.
  case "${TERM}" in
    xterm* | rxvt*)
      PS1="\[\e]0;${debian_chroot:+(${debian_chroot})}\u@\h: \W\a\]${PS1}"
      ;;
    *) ;;
  esac
}

PROMPT_COMMAND=__make_prompt  # set dynamic prompt
