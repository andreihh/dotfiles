#!/bin/sh
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
# Dependencies: `git`

# Exit if any command fails.
set -e

[ $# -ne 1 ] && echo "Usage: $0 <firefox-profile-dir>" && exit 1

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly USER_OVERRIDES="${XDG_CONFIG_HOME}/firefox/user-overrides.js"

echo "Configuring Arkenfox..."
profile_dir="$1"

echo "Creating temporary Arkenfox installation directory..."
arkenfox_dir="$(mktemp -d "${TMPDIR:-/tmp}/arkenfox.XXXXXXXXX")"

echo "Cloning Arkenfox repository..."
git clone --depth=1 https://github.com/arkenfox/user.js "${arkenfox_dir}"

echo "Copying relevant files to the provided Firefox profile..."
for file in 'prefsCleaner.sh' 'updater.sh' 'user.js'; do
  cp -fv "${arkenfox_dir}/${file}" "${profile_dir}/"
done

echo "Linking Arkenfox overrides..."
ln -sfv "${USER_OVERRIDES}" "${profile_dir}/user-overrides.js"

echo "Updating Arkenfox..."
cd "${profile_dir}"
./updater.sh -u -s
./prefsCleaner.sh -s

echo "Configured Arkenfox successfully!"
