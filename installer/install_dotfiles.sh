#!/bin/bash -e

# Installs the `~/.dotfiles` as symlinks in the home directory.
#
# If installing a single file fails, aborts the installation and reports the
# failure.

usage() {
  cat << EOF
  Usage: $0 [-h] [-d] -o <operating-system>

    -h  Print this message and exit.
    -d  Debug / dry run mode (simulate all actions, but do not execute them).
    -o  Operating system directory with platform-specific dotfiles.
EOF
}

while getopts "hdo:" option; do
  case "${option}" in
    h) usage && exit 0 ;;
    d) debug="-d" ;;
    o) os_dir="${OPTARG}" ;;
    *) usage && exit 1 ;;
  esac
done

[[ -z "${os_dir}" ]] && usage && exit 1

echo "Installing dotfiles..."
[[ -n "${debug}" ]] && echo "Running in debug mode!"

for file in "${HOME}/.dotfiles"{,/${os_dir}}/.[!.]*; do
  [[ ! -f "${file}" ]] && continue
  echo "Installing dotfile '${file}'..."
  filename=$(basename "${file}")
  [[ -n "${debug}" ]] || ln -sfv "${file}" "${HOME}/${filename}"
done

echo "Dotfiles installed successfully!"
