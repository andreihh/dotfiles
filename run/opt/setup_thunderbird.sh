#!/bin/sh
#
# Configures settings and preferences for the `${USER}` profile in
# `${XDG_DOCUMENTS_DIR:-${HOME}/Documents}/thunderbird/${USER}`.
#
# See https://github.com/HorlogeSkynet/thunderbird-user.js.
#
# Dependencies: `git`, `xdg-user-dirs` (optional)

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

DOCUMENTS="$(xdg-user-dir DOCUMENTS 2> /dev/null || echo "${HOME}/Documents")"
readonly DOCUMENTS
readonly USER_OVERRIDES="${XDG_CONFIG_HOME:-${HOME}/.config}/thunderbird/user-overrides.js"
readonly GIT_REPO='https://github.com/HorlogeSkynet/thunderbird-user.js'

echo "Configuring 'thunderbird-user.js'..."

echo "Setting up profile directory..."
profile_dir="${DOCUMENTS}/thunderbird/${USER}"
mkdir -p "${profile_dir}"

echo "Creating temporary 'thunderbird-user.js' installation directory..."
tb_user_js_dir="$(mktemp -d "${TMPDIR:-/tmp}/tb_user_js.XXXXXXXXX")"

echo "Cloning 'thunderbird-user.js' repository..."
git clone --depth=1 "${GIT_REPO}" "${tb_user_js_dir}"

echo "Copying relevant files to the provided Thunderbird profile..."
for file in 'prefsCleaner.sh' 'updater.sh' 'user.js'; do
  cp -fv "${tb_user_js_dir}/${file}" "${profile_dir}/"
done

echo "Linking 'thunderbird-user.js' overrides..."
ln -sfv "${USER_OVERRIDES}" "${profile_dir}/user-overrides.js"

echo "Updating 'thunderbird-user.js'..."
cd "${profile_dir}"
./updater.sh -u -s
./prefsCleaner.sh -s

echo "Configured 'thunderbird-user.js' successfully!"
cat << EOF
Update the following settings:
- Folder Modes > Favorite Folders, Unread Folders, All Folders
- Show "Get Messages"
- Show "New Message"
- Settings > Add-ons and Themes > Cogwheel > Install Add-on From File > ...

Ensure the following profile exists in '~/.thunderbird/profiles.ini':
Name=${USER}
IsRelative=0
Path=${profile_dir}
Default=1
EOF
