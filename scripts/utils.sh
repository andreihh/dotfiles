# Various utilities used across installation scripts.

# The standard location of the dotfiles repository.
readonly DOTFILES_DIR="$HOME/.dotfiles"

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
