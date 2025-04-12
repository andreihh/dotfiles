#!/bin/bash -e
#
# Dotfiles installation script:
# - Clones the dotfiles repository
# - Backs up existing dotfiles
# - Installs dotfiles
#
# Supports Debian, Ubuntu, Fedora, and MacOSX.
#
# Requirements:
# - MacOS: Homebrew

readonly REPOSITORY_URL="git@codeberg.org:andreihh/dotfiles.git"
readonly DOTFILES_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/dotfiles"
readonly BACKUP_DIR_DEFAULT="${DOTFILES_HOME}.bak"

function usage() {
  cat << EOF
Usage: $0 [-h] [-d] [-f] [-b BACKUP_DIR] [-r SCRIPTS]

Options:
  -d  Debug / dry run mode (simulate all actions, but do not execute them).
  -f  Force install by deleting prior backup and installation.
  -b  Directory where dotfiles should be backed up, or skip if empty string.
        Default: '${BACKUP_DIR_DEFAULT}'
  -h  Print this message and exit.
EOF
}

backup_dir="${BACKUP_DIR_DEFAULT}"
while getopts 'dfb:h' option; do
  case "${option}" in
    d) debug='-d' ;;
    f) force='-f' ;;
    b) backup_dir="${OPTARG}" ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing dotfiles..."
[[ -n "${debug}" ]] && echo "Running in debug mode!"

echo "Installing required dependencies..."
if [[ -z "${debug}" ]]; then
  command -v apt-get && sudo apt-get install -y git ansible
  command -v dnf && sudo dnf install git ansible
  command -v brew && brew install git ansible
fi

if [[ -n "${force}" ]]; then
  echo "Deleting prior backup and installation..."
  [[ -n "${debug}" ]] || rm -rf "${backup_dir}" "${DOTFILES_HOME}"
else
  [[ -e "${backup_dir}" ]] && echo "Not overwriting existing backup!" && exit 1
fi

if [[ -e "${DOTFILES_HOME}" ]]; then
  echo "Dotfiles repository already cloned!"
else
  echo "Cloning dotfiles repository..."
  git clone "${REPOSITORY_URL}" "${DOTFILES_HOME}"
fi

echo "Checking that the Git repository is clean..."
if [[ -n $(git -C "${DOTFILES_HOME}" status --porcelain 2> /dev/null) ]]; then
  echo "You must commit changes to the Git repository and get to a clean state!"
  [[ -n "${debug}" ]] || exit 1
fi

echo "Stowing dotfiles, adopting conflicting files..."
stow ${debug:+"-n"} -v --no-folding --adopt -t "${HOME}" -d "${DOTFILES_HOME}" .

if [[ -n "${backup_dir}" ]]; then
  echo "Setting up backup directory '${backup_dir}'..."
  [[ -n "${debug}" ]] || mkdir -p "${backup_dir}"

  echo "Backing up dotfiles..."
  [[ -n "${debug}" ]] || cp -Pr "${DOTFILES_HOME}" "${backup_dir}"
fi

echo "Reverting changes from adopted files..."
[[ -n "${debug}" ]] || git -C "${DOTFILES_HOME}" checkout .

FDFIND="$(command -v fdfind)"
readonly FDFIND
if [[ -f "${FDFIND}" ]]; then
  echo "Linking 'fd' to 'fdfind'..."
  [[ -n "${debug}" ]] || ln -sfv "${FDFIND}" "${HOME}/.local/bin/fd"
fi

BATCAT="$(command -v batcat)"
readonly BATCAT
if [[ -f "${BATCAT}" ]]; then
  echo "Linking 'bat' to 'batcat'..."
  [[ -n "${debug}" ]] || ln -sfv "${BATCAT}" "${HOME}/.local/bin/bat"
fi

echo "Removing shell-specific profile config files..."
for shell_profile_file in ~/.{bash_profile,zprofile}; do
  [[ -n "${debug}" ]] || rm -fv "${shell_profile_file}"
done

echo "Dotfiles installed successfully!"
