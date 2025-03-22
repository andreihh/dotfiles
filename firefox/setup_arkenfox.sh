#!/bin/bash -e
#
# Configures the latest version of Arkenfox for a given Firefox profile.
#
# To find the profile folder, open `about:support` and look for `Profile Folder`
# under `Application Basics`. Close Firefox before running this script.
#
# See https://github.com/arkenfox/user.js.
#
# Requires `git`.

[[ $# -ne 1 ]] && echo "Usage: $0 FIREFOX_PROFILE_DIR" && exit 1

readonly USER_OVERRIDES="${XDG_CONFIG_HOME:?}/dotfiles/firefox/user-overrides.js"
readonly PROFILE_DIR="$1"
# shellcheck disable=SC2155
readonly TMP_DIR="$(mktemp -d)"

echo "Cloning Arkenfox repository..."
git clone --depth=1 https://github.com/arkenfox/user.js "${TMP_DIR}"

echo "Copying relevant files to the provided Firefox profile..."
cp -fv "${TMP_DIR}"/{prefsCleaner.sh,updater.sh,user.js} "${PROFILE_DIR}/"

echo "Linking Arkenfox overrides..."
ln -sfv "${USER_OVERRIDES}" "${PROFILE_DIR}/user-overrides.js"

echo "Cleaning up Arkenfox repository..."
rm -rf "${TMP_DIR:?}"

echo "Updating Arkenfox..."
cd "${PROFILE_DIR}"
./updater.sh -u -s
./prefsCleaner.sh -s

echo "Configured Arkenfox successfully!"
