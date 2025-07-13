#!/bin/sh
#
# Dotfiles installation script:
# - Installs required dependencies
# - Clones the dotfiles repository
# - Backs up existing dotfiles
# - Installs dotfiles
# - Runs setup scripts
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, and MacOS.
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly REPOSITORY_URL='https://codeberg.org/andreihh/dotfiles.git'
readonly DOTFILES_HOME="${XDG_CONFIG_HOME}/dotfiles"
readonly BACKUP_DIR_DEFAULT="${DOTFILES_HOME}.bak"

usage() {
  cat << EOF
Usage: $0 [-h] [-n] [-f] [-b BACKUP_DIR] [-u]

Options:
  -n  Perform a dry run (simulate actions, but do not execute them).
  -b  Directory where dotfiles should be backed up, or skip if empty string.
        Default: '${BACKUP_DIR_DEFAULT}'
  -u  Update dotfiles without running setup scripts.
  -h  Print this message and exit.
EOF
}

backup_dir="${BACKUP_DIR_DEFAULT}"
while getopts 'nb:uh' option; do
  case "${option}" in
    n) dry_run=true ;;
    b) backup_dir="${OPTARG}" ;;
    u) skip_scripts=true ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing dotfiles..."

[ -n "${dry_run}" ] && echo "Performing a dry run!"

echo "Ensuring dependencies are installed..."
for dep in 'git' 'stow'; do
  if ! command -v "${dep}" > /dev/null 2>&1; then
    command -v apt-get > /dev/null 2>&1 && sudo apt-get install -y "${dep}"
    command -v dnf > /dev/null 2>&1 && sudo dnf install -y "${dep}"
    command -v brew > /dev/null 2>&1 && brew install "${dep}"
  fi
done

[ -e "${backup_dir}" ] \
  && echo "Not overwriting existing backup '${backup_dir}'!" \
  && exit 1

if [ -e "${DOTFILES_HOME}" ]; then
  echo "Dotfiles repository already cloned at '${DOTFILES_HOME}'!"
else
  echo "Cloning dotfiles repository to '${DOTFILES_HOME}'..."
  git clone "${REPOSITORY_URL}" "${DOTFILES_HOME}"
fi

echo "Checking that the Git repository is clean..."
if [ -n "$(git -C "${DOTFILES_HOME}" status --porcelain 2> /dev/null)" ]; then
  echo "You must commit changes to the Git repository and get to a clean state!"
  [ -n "${dry_run}" ] || exit 1
fi

echo "Stowing dotfiles, adopting conflicting files..."
stowdir() {
  _src="$1"
  _dst="$2"
  stow ${dry_run:+'-n'} -v --no-folding --adopt -t "${_dst}" -d "${_src}" .
}

stowdir "${DOTFILES_HOME}" "${HOME}"
stowdir "${DOTFILES_HOME}/config" "${XDG_CONFIG_HOME}"
stowdir "${DOTFILES_HOME}/data" "${XDG_DATA_HOME}"

if [ -n "${backup_dir}" ]; then
  echo "Setting up backup directory '${backup_dir}'..."
  [ -n "${dry_run}" ] || mkdir -p "${backup_dir}"

  echo "Backing up dotfiles to '${backup_dir}'..."
  [ -n "${dry_run}" ] || cp -Pr "${DOTFILES_HOME}" "${backup_dir}"
fi

echo "Reverting changes from adopted files..."
[ -n "${dry_run}" ] || git -C "${DOTFILES_HOME}" checkout .

echo "Removing shell-specific configs to ensure '~/.profile' is loaded..."
for shell_config in '.bash_profile' '.bash_login'; do
  [ -n "${dry_run}" ] || rm -fv "${HOME}/${shell_config}"
done

if [ -z "${skip_scripts}" ]; then
  echo "Running setup scripts..."
  # Name scripts with a number prefix (e.g., `10-script.sh`) to enforce a
  # specific execution order. This is required to ensure script dependencies are
  # installed before they are run.
  for script in "${DOTFILES_HOME}/run"/*.sh; do
    echo "Running '$(basename "${script}")'..."
    [ -n "${dry_run}" ] || "${script}"
  done
fi

echo "Installed dotfiles successfully!"
