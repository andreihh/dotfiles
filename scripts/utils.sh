# Various utilities used across installation scripts.

# The standard location of the dotfiles repository.
readonly DOTFILES_DIR="$HOME/.dotfiles"

# The list of core packages common to all platforms.
readonly CORE_PACKAGES=\
"firefox wget curl git vim tmux lm-sensors tree urlview calc dos2unix "

# Prints the given message in red to stderr.
function echoerr() {
  echo -e "\033[0;31m$@\033[0m" >&2
}

# Returns the platform of the current system (one of `linux` or `macos`).
function get_platform() {
  local platform
  shopt -s nocasematch
  case "$OSTYPE" in
    linux*) platform="linux" ;;
    darwin*) platform="macos" ;;
    *) platform="" ;;
  esac
  shopt -u nocasematch
  echo "$platform"
}

# Installs the provided list of packages using the given installation command.
function install_packages() {
  local installer="$1"
  shift 1

  for package in "$@"; do
    echo "Installing package '$package'..."
    $installer "$package" || echoerr "Failed to install package '$package'!"
  done
}

# Downloads the packages located at the given URLs. Requires `wget` or `curl`.
function download_packages() {
  for url in "$@"; do
    echo "Downloading '$url'..."
    wget "$url" || curl -LO "$url" || echoerr "Failed to download '$url'!"
  done
}
