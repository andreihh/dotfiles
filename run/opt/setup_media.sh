#!/bin/sh
#
# Installs media packages, sets `XDG_PICTURES_DIR` and `XDG_VIDEOS_DIR` to
# `XDG_MEDIA_DIR` (defaults to `~/Media`), and moves their contents there.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

readonly XDG_MEDIA_DIR="${XDG_MEDIA_DIR:-${HOME}/Media}"

usage() {
  cat << EOF
Usage: $0 [-h] [-n]

Options:
  -n  Perform a dry run (simulate actions, but do not execute them).
  -h  Print this message and exit.
EOF
}

while getopts 'nh' option; do
  case "${option}" in
    n) dry_run=true ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

echo "Installing media packages..."
install-pkg xdg-user-dirs rclone vlc cava
has-cmd apt-get && install-pkg cmus
has-cmd brew && install-pkg cmus

echo "Creating XDG media directory '${XDG_MEDIA_DIR}'..."
[ -n "${dry_run}" ] || mkdir -p "${XDG_MEDIA_DIR}"

for media_dir_name in 'PICTURES' 'VIDEOS'; do
  media_dir="$(xdg-user-dir "${media_dir_name}")"
  if [ -d "${media_dir}" ] && [ "${media_dir}" != "${XDG_MEDIA_DIR}" ]; then
    echo "Moving contents from '${media_dir}' to '${XDG_MEDIA_DIR}'..."
    rclone --config= move ${dry_run:+'-n'} --progress --delete-empty-src-dirs \
      "${media_dir}" "${XDG_MEDIA_DIR}"
    [ -n "${dry_run}" ] || rmdir "${media_dir}"
  fi

  echo "Updating 'XDG_${media_dir_name}_DIR' to '${XDG_MEDIA_DIR}'..."
  [ -n "${dry_run}" ] \
    || xdg-user-dirs-update --set "${media_dir_name}" "${XDG_MEDIA_DIR}"
done

echo "Media setup complete!"
