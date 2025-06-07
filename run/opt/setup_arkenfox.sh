#!/bin/bash -e
#
# Configures the latest version of Arkenfox for a given Firefox profile.
#
# To find the profile folder, open `about:support` and look for `Profile Folder`
# under `Application Basics`. Close Firefox before running this script.
#
# See https://github.com/arkenfox/user.js.
#
# After installing Arkenfox, configure Firefox as follows:
# - Import bookmarks
# - Import `vimium-options.json` and configure excluded URL patterns
# - Configure websites allowed to store cookies and site data under:
#   `Settings > Privacy & Security > Cookies and Site Data > Manage Exceptions`
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies: `git`

[[ $# -ne 1 ]] && echo "Usage: $0 FIREFOX_PROFILE_DIR" && exit 1

readonly USER_OVERRIDES="${XDG_CONFIG_HOME:?}/firefox/user-overrides.js"
readonly PROFILE_DIR="$1"

echo "Creating temporary Arkenfox installation directory..."
ARKENFOX_DIR="$(mktemp -d "${TMPDIR:-/tmp}/arkenfox.XXXXXXXXX")"
readonly ARKENFOX_DIR

echo "Cloning Arkenfox repository..."
git clone --depth=1 https://github.com/arkenfox/user.js "${ARKENFOX_DIR}"

echo "Copying relevant files to the provided Firefox profile..."
cp -fv "${ARKENFOX_DIR}"/{prefsCleaner.sh,updater.sh,user.js} "${PROFILE_DIR}/"

echo "Linking Arkenfox overrides..."
ln -sfv "${USER_OVERRIDES}" "${PROFILE_DIR}/user-overrides.js"

echo "Cleaning up Arkenfox installation..."
rm -rf "${ARKENFOX_DIR}"

echo "Updating Arkenfox..."
cd "${PROFILE_DIR}"
./updater.sh -u -s
./prefsCleaner.sh -s

echo "Configured Arkenfox successfully!"
