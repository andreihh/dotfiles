#!/bin/bash -e

# Backs up all dotfiles to the given directory.
#
# If the backup directory already exists or a single file backup fails, aborts
# the backup and reports the failure.

usage() {
  cat << EOF
  Usage: $0 [-h] [-d] -b <backup-directory>

    -h  Print this message and exit.
    -d  Debug / dry run mode (simulate all actions, but do not execute them).
    -b  Directory where dotfiles should be backed up.
EOF
}

while getopts "hdb:" option; do
  case "${option}" in
    h) usage && exit 0 ;;
    d) debug="-d" ;;
    b) backup_dir="${OPTARG}" ;;
    *) usage && exit 1 ;;
  esac
done

[[ -z "${backup_dir}" ]] && usage && exit 1

echo "Backing up dotfiles..."
[[ -n "${debug}" ]] && echo "Running in debug mode!"

if [[ -e "${backup_dir}" ]]; then
  echo "You must move the existing backup '${backup_dir}' elsewhere!"
  exit 1
fi

echo "Setting up backup directory '${backup_dir}'..."
[[ -n "${debug}" ]] || mkdir -p "${backup_dir}"

for file in "${HOME}"/.[!.]*; do
  [[ ! -f "${file}" ]] && continue
  echo "Backing up '${file}'..."
  [[ -n "${debug}" ]] || cp -Pv "${file}" "${backup_dir}/"
done

echo "Backup complete!"
