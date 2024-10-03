#!/bin/bash -e

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
# Supports Linux and MacOS. Requires `unzip` and `curl`.

readonly HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

readonly REPO="https://github.com/andreihh/.dotfiles"
readonly BRANCH="main"
readonly REPO_ZIP="${REPO}/archive/${BRANCH}.zip"

readonly DOTFILES_DIR="${HOME}/.dotfiles"
readonly INSTALLER_DIR="${DOTFILES_DIR}/installer"
readonly BACKUP_DOTFILES="${INSTALLER_DIR}/backup_dotfiles.sh"
readonly INSTALL_DOTFILES="${INSTALLER_DIR}/install_dotfiles.sh"
readonly INSTALL_PACKAGES="${INSTALLER_DIR}/install_packages.sh"

shopt -s nocasematch
case "${OSTYPE}" in
  linux*)
    os_dir="linux"
    installer="sudo apt-get -y install"
    updater="sudo apt-get update"
    ;;
  darwin*)
    os_dir="macos"
    installer="brew install"
    updater="brew update"
    command -v brew || install_homebrew=1
    ;;
  *)
    echo "System '${OSTYPE}' not supported!"
    exit 1
    ;;
esac
shopt -u nocasematch

readonly BACKUP_DIR_DEFAULT="${HOME}/.dotfiles.bak"
readonly PACKAGE_INDEX_DEFAULT="${INSTALLER_DIR}/${os_dir}/package_index.txt"

usage() {
  cat << EOF
  Usage: $0 [-h] [-d] [-b <backup-directory>] [-p <package-index>]

    -d  Debug / dry run mode (simulate all actions, but do not execute them).
    -f  Force install by deleting prior backup and installation.
    -b  Directory where dotfiles should be backed up.
          Default: '${BACKUP_DIR_DEFAULT}'
    -p  Path to the package index file. Packages must be delimited by ';'.
          Default: '${PACKAGE_INDEX_DEFAULT}'
    -i  Command to use to install packages.
          Default: '${installer}'
    -u  Command to use to update the package index. Optional.
          Default: '${updater}'
    -s  List of setup scripts to run delimited by ';'.
          Default: all 'setup_*.sh' scripts from '${INSTALLER_DIR}[/${os_dir}]'.
    -h  Print this message and exit.
EOF
}

backup_dir="${BACKUP_DIR_DEFAULT}"
package_index="${PACKAGE_INDEX_DEFAULT}"
while getopts "dfb:p:i:u:s:h" option; do
  case "${option}" in
    d) debug="-d" ;;
    f) force="-f" ;;
    b) backup_dir="${OPTARG}" ;;
    p) package_index="${OPTARG}" ;;
    i) installer="${OPTARG}" ;;
    u) updater="${OPTARG}" ;;
    s) setup_scripts="${OPTARG//;/ }" ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing dotfiles repository..."
[[ -n "${debug}" ]] && echo "Running in debug mode!"

if [[ -n "${install_homebrew}" ]]; then
  echo "Installing Homebrew..."
  [[ -n "${debug}" ]] || /bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALLER})"
fi

if [[ -n "${force}" ]]; then
  echo "Deleting prior backup and installation..."
  [[ -n "${debug}" ]] || rm -rf "${backup_dir}" "${DOTFILES_DIR}"
else
  [[ -e "${backup_dir}" ]] && echo "Backup already exists!" && exit 1
  [[ -e "${DOTFILES_DIR}" ]] && echo "Dotfiles already exist!" && exit 1
fi

echo "Cleaning up prior work files..."
[[ -n "${debug}" ]] || rm -rf "${BRANCH}.zip" ".dotfiles-${BRANCH}/"

echo "Downloading repository..."
[[ -n "${debug}" ]] || curl -LO "${REPO_ZIP}"

echo "Unpacking repository..."
if [[ -z "${debug}" ]]; then
  unzip "${BRANCH}.zip"
  rm "${BRANCH}.zip"
  mv ".dotfiles-${BRANCH}" "${DOTFILES_DIR}"
fi

echo "Running backup and install scripts..."
chmod +x "${BACKUP_DOTFILES}" "${INSTALL_DOTFILES}" "${INSTALL_PACKAGES}"
"${BACKUP_DOTFILES}" ${debug} -b "${backup_dir}"
"${INSTALL_DOTFILES}" ${debug}
"${INSTALL_PACKAGES}" ${debug} -p "${package_index}" -i "${installer}" \
  -u "${updater}"

if [[ -z "${setup_scripts}" ]]; then
  setup_scripts=$(echo "${INSTALLER_DIR}"{,/${os_dir}}/setup_*.sh)
fi

echo "Running setup scripts..."
for script in ${setup_scripts}; do
  echo "Running script '${script}'..."
  chmod +x "${script}"
  if "${script}" ${debug}; then
    echo "Script '${script}' ran successfully!"
  else
    echo -e "\e[31mScript '${script}' failed!\e[0m"
  fi
done

echo "Initializing remote git repository..."
if [[ -z "${debug}" ]]; then
  cd "${DOTFILES_DIR}"
  git init
  git remote add origin "${REPO}.git"
  git fetch
  git checkout -t -f "origin/${BRANCH}"
fi

echo "Installation complete!"
