#!/bin/sh
#
# Configures opinionated XDG user directories.
#
# On XDG-compliant systems:
# - Disable `XDG_DESKTOP_DIR` and `XDG_TEMPLATES_DIR`
# - Set `XDG_PICTURES_DIR` and `XDG_VIDEOS_DIR` to `~/Media`
# - Enforce the XDG specification default values for the remaining directories
#
# Dependencies: `xdg-user-dirs` (on non-MacOS)

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

mv_xdg_dir() {
  [ $# -ne 2 ] && echo "Usage: mv_xdg_dir <name> <dst>" && return 1
  _name="$1"
  _dst="$2"

  echo "Fetching current value of 'XDG_${_name}_DIR'..."
  _src="$(xdg-user-dir "${_name}")"

  echo "Ensuring the destination '${_dst}' exists..."
  mkdir -p "${_dst}"

  echo "Updating 'XDG_${_name}_DIR' from '${_src}' to '${_dst}'..."
  xdg-user-dirs-update --set "${_name}" "${_dst}"

  # Skip the move if `src` isn't a directory or is equal to `HOME` or `dst`.
  ! [ -d "${_src}" ] && return 0
  case "${_src}" in
    "${HOME}" | "${HOME}/" | "${_dst}" | "${_dst}/") return 0 ;;
    *) ;;
  esac

  echo "Moving contents from '${_src}' to '${_dst}'..."
  for _file in "${_src}"/* "${_src}"/.*; do
    [ -e "${_file}" ] && mv -nv "${_file}" "${_dst}/"
  done

  echo "Cleaning up '${_src}'..."
  rmdir -v "${_src}" || echo "Failed to clean up '${_src}', do it manually!"
}

echo "Updating XDG user directories..."
mv_xdg_dir 'DOWNLOAD' "${HOME}/Downloads"
mv_xdg_dir 'PUBLICSHARE' "${HOME}/Public"
mv_xdg_dir 'DOCUMENTS' "${HOME}/Documents"
mv_xdg_dir 'MUSIC' "${HOME}/Music"
mv_xdg_dir 'PICTURES' "${HOME}/Media"
mv_xdg_dir 'VIDEOS' "${HOME}/Media"

for name in 'DESKTOP' 'TEMPLATES'; do
  backup_dir="${HOME}/Media/tmp/$(echo "${name}" | tr '[:upper:]' '[:lower:]')"
  echo "Backing up 'XDG_${name}_DIR' to '${backup_dir}'..."
  mv_xdg_dir "${name}" "${backup_dir}"

  echo "Disabling 'XDG_${name}_DIR'..."
  xdg-user-dirs-update --set "${name}" "${HOME}"
done

echo "Configured XDG directories successfully!"
