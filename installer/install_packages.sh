#!/bin/bash -e
#
# Updates and installs the given packages with the given installer and updater.

usage() {
  cat << EOF
  Usage: $0 [-h] [-d] -p <package-index> -i <installer> [-u <updater>]

    -d  Debug / dry run mode (simulate all actions, but do not execute them).
    -p  Path to the package index file. Packages must be delimited by ';'.
    -i  Command to use to install packages.
    -u  Command to use to update the package index. Optional.
    -h  Print this message and exit.
EOF
}

while getopts "dp:i:u:h" option; do
  case "${option}" in
    d) debug="-d" ;;
    p) package_index="${OPTARG}" ;;
    i) installer="${OPTARG}" ;;
    u) updater="${OPTARG}" ;;
    h) usage && exit 0 ;;
    *) usage && exit 1 ;;
  esac
done

[[ -z "${package_index}" ]] && usage && exit 1
[[ -z "${installer}" ]] && usage && exit 1

echo "Installing packages..."
[[ -n "${debug}" ]] && echo "Running in debug mode!"

if [[ -n "${updater}" ]]; then
  echo "Updating package index..."
  [[ -n "${debug}" ]] || ${updater}
fi

packages=$(cat "${package_index}" | tr ";" "\n")

echo "${packages}" | while read -r package; do
  [[ -z "${package}" ]] && continue
  echo "Installing package '${package}'..."
  [[ -n "${debug}" ]] || ${installer} ${package}
done

# shellcheck disable=SC2155
readonly FDFIND="$(command -v fdfind)"
if [[ -f "${FDFIND}" ]]; then
  echo "Linking 'fd' to 'fdfind'..."
  [[ -n "${debug}" ]] || ln -svf "${FDFIND}" "${HOME}/.local/bin/fd"
fi

# shellcheck disable=SC2155
readonly BATCAT="$(command -v batcat)"
if [[ -f "${BATCAT}" ]]; then
  echo "Linking 'bat' to 'batcat'..."
  [[ -n "${debug}" ]] || ln -svf "${BATCAT}" "${HOME}/.local/bin/bat"
fi

echo "Packages installed successfully!"
