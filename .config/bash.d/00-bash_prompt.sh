# bash_prompt.sh: customizes the shell prompt.

# Controls how many components are displayed from the current working directory:
# - `0` to display full path
# - `n` for the last `n` components, others will be collapsed to their initials
# Must be a non-negative integer.
export SHORTEN_PWD_PROMPT_LEVEL=5

# Command used to detect the current VCS branch to be included in the prompt:
# - default is `__vcs_branch`
# - unset to drop VCS info from the prompt
# - set to custom function to work with other systems
export VCS_BRANCH_PROMPT_COMMAND="__vcs_branch"

# Returns the current `git` branch and dirty status.
__git_branch() {
  git rev-parse --is-inside-work-tree &> /dev/null || return

  local branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null \
    || git describe --all --exact-match HEAD 2> /dev/null \
    || git rev-parse --short HEAD 2> /dev/null \
    || echo '(unknown)')"

  local dirty=""
  if [[ $(git status --porcelain 2> /dev/null) ]]; then
    dirty="*"
  fi

  echo "${branch}${dirty}"
}

# Returns the branch name and optionally dirty status of the current VCS branch.
#
# Works with `git`.
__vcs_branch() {
  local git_branch="$(__git_branch)"
  if [[ -n "${git_branch}" ]]; then
    echo "${git_branch}"
    return
  fi
}

# Shortens the current working directory by collapsing `${HOME}` to `~` and the
# path components to their initials, except for the last 5 components, which are
# displayed in full.
__short_pwd() {
  local pwd_tilde="${PWD#"${HOME}"}"
  [[ "${PWD}" != "${pwd_tilde}" ]] && printf '~'
  IFS='/' read -r -a path <<< "${pwd_tilde:1}"

  local -i length=${#path[@]}
  local -i trim_length
  ((trim_length = length - SHORTEN_PWD_PROMPT_LEVEL))

  if ((trim_length <= 0 || SHORTEN_PWD_PROMPT_LEVEL <= 0)); then
    printf '%s' "${pwd_tilde}"
    return
  fi

  local -i index
  for ((index = 0; index < trim_length; index++)); do
    printf '%s' "/${path[index]:0:1}"
  done
  for ((index = trim_length; index < length; index++)); do
    printf '%s' "/${path[index]}"
  done
}

# Makes a custom, dynamic prompt in the following format:
#   `(chroot) user at host on branch in dir $`
#
# The chroot, host and branch are optional. Colors are used only if supported.
__make_prompt() {
  # If colors are supported, define styles and colors.
  local ncolors=$(tput colors)
  if [[ -n "${ncolors}" ]] && [[ ${ncolors} -ge 8 ]]; then
    local reset_style="\[$(tput sgr0)\]"

    local text_style="\[$(tput sgr0 && tput bold)\]"
    local shell_style="\[$(tput sgr0 && tput bold && tput setaf 2)\]"  # green
    local chroot_style="\[$(tput sgr0 && tput bold && tput setaf 5)\]"  # purple
    local user_style="\[$(tput sgr0 && tput bold && tput setaf 1)\]"  # red
    local host_style="\[$(tput sgr0 && tput bold && tput setaf 2)\]"  # green
    local vcs_style="\[$(tput sgr0 && tput bold && tput setaf 3)\]"  # yellow
    local cwd_style="\[$(tput sgr0 && tput bold && tput setaf 4)\]"  # blue
  fi

  # Set variable identifying the chroot you work in.
  if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # Set the terminal prompt.
  PS1="${debian_chroot:+${chroot_style}(${debian_chroot}) }"  # set chroot
  PS1+="${user_style}\u"  # set current user

  # Set the host only if the current session is remote.
  if [[ -n "${SSH_TTY}" ]]; then
    PS1+="${text_style} at ${host_style}\h"
  fi

  # Set current VCS branch if VCS info is enabled and repository is detected.
  if [[ -n "${VCS_BRANCH_PROMPT_COMMAND}" ]]; then
    local branch="$(${VCS_BRANCH_PROMPT_COMMAND})"
    if [[ -n "${branch}" ]]; then
      PS1+="${text_style} on ${vcs_style}${branch}"
    fi
  fi

  PS1+="${text_style} in ${cwd_style}$(__short_pwd)"  # set short cwd
  PS1+="\n${shell_style}\$ ${reset_style}"  # set shell and reset style

  PS2="${shell_style}> ${reset_style}"  # set shell and reset style

  # If this is an xterm, set the title to user@host:dir.
  case "${TERM}" in
    xterm* | rxvt*)
      PS1="\[\e]0;${debian_chroot:+(${debian_chroot})}\u@\h: \W\a\]${PS1}"
      ;;
    *) ;;
  esac
}

PROMPT_COMMAND=__make_prompt  # set dynamic prompt
