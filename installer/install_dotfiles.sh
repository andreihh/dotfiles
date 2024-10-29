#!/bin/bash -e
#
# Installs the dotfiles repository as symlinks in the home directory.
#
# If installing a single file fails, aborts the installation and reports the
# failure.

readonly DOTFILES_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/dotfiles"

usage() {
  cat << EOF
  Usage: $0 [-h] [-d] [-b <backup_dir>]

    -d  Debug / dry run mode (simulate all actions, but do not execute them).
    -b  Backup directory where dotfiles should be copied to.
    -h  Print this message and exit.
EOF
}

while getopts "db:o:h" option; do
  case "${option}" in
    d)
      debug="-d"
      stow_debug="-n"
      ;;
    b) backup_dir="${OPTARG}" ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing dotfiles..."
[[ -n "${debug}" ]] && echo "Running in debug mode!"

if [[ ! -d "${DOTFILES_HOME}" ]]; then
  echo "Dotfiles repository '${DOTFILES_HOME}' is missing!"
  exit 1
fi

echo "Checking that the Git repository is clean..."
if [[ $(git -C "${DOTFILES_HOME}" status --porcelain 2> /dev/null) ]]; then
  echo "You must commit changes to the Git repository and get to a clean state!"
  exit 1
fi

if [[ -n "${backup_dir}" ]]; then
  if [[ -e "${backup_dir}" ]]; then
    echo "You must move the existing backup '${backup_dir}' elsewhere!"
    exit 1
  fi
fi

echo "Stowing dotfiles, adopting conflicting files..."
stow ${stow_debug} -v --no-folding --adopt -t "${HOME}" -d "${DOTFILES_HOME}" .

if [[ -n "${backup_dir}" ]]; then
  echo "Setting up backup directory '${backup_dir}'..."
  [[ -n "${debug}" ]] || mkdir -p "${backup_dir}"

  echo "Backing up dotfiles..."
  [[ -n "${debug}" ]] || cp -Pr "${DOTFILES_HOME}" "${backup_dir}"
fi

echo "Reverting changes from adopted files..."
[[ -n "${debug}" ]] || git -C "${DOTFILES_HOME}" checkout .

echo "Removing shell-specific profile config files..."
for shell_profile_file in ~/.{bash_profile,zprofile}; do
  [[ -n "${debug}" ]] || rm -vf "${shell_profile_file}"
done

echo "Changing default shell to Bash..."
chsh -s "/bin/bash"

echo "Dotfiles installed successfully!"
