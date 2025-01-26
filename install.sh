#!/bin/bash -e
#
# Dotfiles installation script:
# - Clones the dotfiles repository
# - Backs up existing dotfiles
# - Installs the dotfiles
# - Runs setup scripts
#
# If any step in the installation fails, you may fix the issues manually and
# run this script again. However, you must move any generated backups to a
# different location, or force overwriting.
#
# Supports Linux and MacOS. Requires `git`, which is bundled with most Linux
# distributions and with XCode Command Line Tools on MacOS.

readonly CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

readonly REPOSITORY_URL="https://github.com/andreihh/dotfiles"
readonly DOTFILES_HOME="${CONFIG_HOME}/dotfiles"
readonly BACKUP_DIR_DEFAULT="${CONFIG_HOME}/dotfiles.bak"
readonly RUN_DIR="${DOTFILES_HOME}/run"

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

usage() {
  cat << EOF
Usage: $0 [-h] [-d] [-f] [-b <backup-directory>] [-r <script-list>]

  -d  Debug / dry run mode (simulate all actions, but do not execute them).
  -f  Force install by deleting prior backup and installation.
  -b  Directory where dotfiles should be backed up.
        Default: '${BACKUP_DIR_DEFAULT}'
  -r  List of scripts to run delimited by ';'.
        Default: all '*.sh' scripts in '${RUN_DIR}[/${os_type}]'.
  -h  Print this message and exit.
EOF
}

backup_dir="${BACKUP_DIR_DEFAULT}"
while getopts "dfb:r:h" option; do
  case "${option}" in
    d) debug="-d" ;;
    f) force="-f" ;;
    b) backup_dir="${OPTARG}" ;;
    r) run_scripts="${OPTARG//;/ }" ;;
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

echo "Removing shell-specific profile config files..."
for shell_profile_file in ~/.{bash_profile,zprofile}; do
  [[ -n "${debug}" ]] || rm -vf "${shell_profile_file}"
done

echo "Dotfiles installed successfully!"

if [[ -z "${run_scripts+set}" ]]; then
  # Run common scripts last to ensure OS packages are installed first.
  run_scripts=$(echo "${RUN_DIR}"{/"${os_type}",}/*.sh)
fi

echo "Running scripts..."
for script in ${run_scripts}; do
  echo "Running script '${script}'..."
  [[ -n "${debug}" ]] && continue
  chmod +x "${script}"
  "${script}" <&0 || echo -e "\e[31mScript '${script}' failed!\e[0m"
done

echo "Installation complete!"
