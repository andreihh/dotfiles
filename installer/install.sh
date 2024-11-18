#!/bin/bash -e
#
# Downloads the dotfiles repository and runs:
# - the dotfile backup script
# - the package installer script
# - the dotfile installer script
# - the given setup scripts
#
# After the installation is complete, it sets up the remote git repository.
#
# If any step in the installation fails, you may fix the issues manually and
# run this script again. However, you must move any generated backups to a
# different location.
#
# Supports Linux and MacOS. Requires `git`, which is bundled with most Linux
# distributions and with XCode Command Line Tools on MacOS.

readonly REPOSITORY_URL="https://github.com/andreihh/dotfiles"
readonly DOTFILES_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/dotfiles"
readonly INSTALLER_DIR="${DOTFILES_HOME}/installer"

shopt -s nocasematch
case "${OSTYPE}" in
  linux*) os_type="linux" ;;
  darwin*)
    os_type="macos"
    echo "Installing XCode Command Line Tools..."
    xcode-select --install
    ;;
  *) echo "System '${OSTYPE}' not supported!" && exit 1 ;;
esac
shopt -u nocasematch

readonly BACKUP_DIR_DEFAULT="${XDG_CONFIG_HOME:-${HOME}/.config}/dotfiles.bak"

usage() {
  cat << EOF
Usage: $0 [-h] [-d] [-f] [-b <backup-directory>] [-s <script-list> ]

  -d  Debug / dry run mode (simulate all actions, but do not execute them).
  -f  Force install by deleting prior backup and installation.
  -b  Directory where dotfiles should be backed up.
        Default: '${BACKUP_DIR_DEFAULT}'
  -s  List of setup scripts to run delimited by ';'.
        Default: all 'setup_*.sh' scripts in '${INSTALLER_DIR}[/${os_type}]'.
  -h  Print this message and exit.
EOF
}

backup_dir="${BACKUP_DIR_DEFAULT}"
while getopts "dfb:s:h" option; do
  case "${option}" in
    d) debug="-d" ;;
    f) force="-f" ;;
    b) backup_dir="${OPTARG}" ;;
    s) setup_scripts="${OPTARG//;/ }" ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing dotfiles..."
[[ -n "${debug}" ]] && echo "Running in debug mode!"

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
  [[ -n "${debug}" ]] || git clone "${REPOSITORY_URL}" "${DOTFILES_HOME}"
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

echo "Removing shell-specific profile config files..."
for shell_profile_file in ~/.{bash_profile,zprofile}; do
  [[ -n "${debug}" ]] || rm -vf "${shell_profile_file}"
done

echo "Dotfiles installed successfully!"

if [[ -z "${setup_scripts}" ]]; then
  setup_scripts=$(echo "${INSTALLER_DIR}"{,/"${os_type}"}/setup_*.sh)
fi

echo "Running setup scripts..."
for script in ${setup_scripts}; do
  echo "Running script '${script}'..."
  [[ -n "${debug}" ]] && continue
  chmod +x "${script}"
  "${script}" <&0 || echo -e "\e[31mScript '${script}' failed!\e[0m"
done

echo "Changing default shell to Bash..."
[[ -n "${debug}" ]] || chsh -s "/bin/bash"

echo "Installation complete!"
