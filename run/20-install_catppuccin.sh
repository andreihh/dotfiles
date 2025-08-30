#!/bin/sh
#
# Installs Catppuccin Frappe theme with blue accent.
#
# See https://catppuccin.com.
#
# Dependencies: `git`, `wget`, `unzip`, `bash` + `sassc` (optional, for GTK)

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly THEME_GIT_URL='https://github.com/catppuccin'
readonly THEME_CURSORS_URL="${THEME_GIT_URL}/cursors/releases/latest/download"

echo "Installing Catppuccin Frappe theme with blue accent..."

echo "Creating temporary Catppuccin installation directory..."
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/catppuccin.XXXXXXXXX")"

echo "Creating application theme directories..."
for app in 'alacritty' 'fzf' 'bat' 'lsd' 'thunderbird'; do
  mkdir -p "${XDG_CONFIG_HOME}/${app}/themes"
done

echo "Downloading Alacritty theme..."
wget -O "${XDG_CONFIG_HOME}/alacritty/themes/catppuccin-frappe.toml" \
  "${THEME_GIT_URL}/alacritty/raw/main/catppuccin-frappe.toml"

echo "Configuring Alacritty theme..."
cat << EOF > "${XDG_CONFIG_HOME}/alacritty/theme.toml"
# theme: configures Alacritty theme.
#
# Alacritty config cannot import dynamic files.

[general]
import = ["themes/catppuccin-frappe.toml"]
EOF

echo "Configuring Ghostty theme..."
cat << EOF > "${XDG_CONFIG_HOME}/ghostty/theme"
# theme: configures Ghostty theme.
#
# Ghostty config cannot set dynamic themes.

theme = "catppuccin-frappe"
EOF

echo "Downloading 'fzf' theme..."
wget -O "${XDG_CONFIG_HOME}/fzf/themes/catppuccin-frappe.sh" \
  "${THEME_GIT_URL}/fzf/raw/main/themes/catppuccin-fzf-frappe.sh"

echo "Downloading 'bat' theme..."
wget -O "${XDG_CONFIG_HOME}/bat/themes/catppuccin-frappe.tmTheme" \
  "${THEME_GIT_URL}/bat/raw/main/themes/Catppuccin Frappe.tmTheme"

echo "Updating 'bat' cache..."
bat cache --build

echo "Downloading 'lsd' theme..."
wget -O "${XDG_CONFIG_HOME}/lsd/themes/catppuccin-frappe.yaml" \
  "${THEME_GIT_URL}/lsd/raw/main/themes/catppuccin-frappe/colors.yaml"

echo "Linking 'lsd' colors..."
ln -sfv "${XDG_CONFIG_HOME}/lsd/themes/catppuccin-frappe.yaml" \
  "${XDG_CONFIG_HOME}/lsd/colors.yaml"

echo "Downloading 'thunderbird' theme..."
wget -O "${XDG_CONFIG_HOME}/thunderbird/themes/catppuccin-frappe.xpi" \
  "${THEME_GIT_URL}/thunderbird/raw/main/themes/frappe/frappe-blue.xpi"

echo "Configuring shell theme..."
cat << EOF > "${XDG_CONFIG_HOME}/env.d/10-theme.sh"
# theme.sh: configures shell theme.
#
# shellcheck shell=sh

export TMUX_THEME='catppuccin-frappe'
export NVIM_THEME='catppuccin-frappe'
export VIM_THEME='catppuccin_frappe'
export BAT_THEME='catppuccin-frappe'

fzf_theme="\${XDG_CONFIG_HOME:-\${HOME}/.config}/fzf/themes/catppuccin-frappe.sh"
if [ -f "\${fzf_theme}" ]; then
  . "\${fzf_theme}"
fi
unset fzf_theme
EOF

echo "Downloading cursor theme..."
wget -P "${tmp_dir}/cursors" \
  "${THEME_CURSORS_URL}/catppuccin-frappe-dark-cursors.zip"

echo "Unpacking cursor theme..."
unzip -od "${XDG_DATA_HOME}/icons/" "${tmp_dir}/cursors/*.zip"

has-cmd snap \
  && echo "Installing Snap cursor theme..." \
  && sudo snap install cursor-theme-catppuccin

if [ -n "${HEADLESS}" ]; then
  echo "Headless installation, skipped GTK installation!"
else
  echo "Downloading GTK theme..."
  # https://github.com/catppuccin/gtk was archived, so download an alternative.
  git clone --depth 1 https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme \
    "${tmp_dir}/gtk"

  echo "Installing GTK theme..."
  "${tmp_dir}/gtk/themes/install.sh" \
    --dest "${XDG_DATA_HOME}/themes" --libadwaita --tweaks outline \
    --tweaks frappe

  has-cmd dconf \
    && echo "Configuring GNOME theme..." \
    && dconf load / << EOF
[org/gnome/shell/extensions/user-theme]
name='Catppuccin-Dark-Frappe'

[org/gnome/desktop/background]
picture-uri='file://${XDG_DATA_HOME}/wallpapers/catppuccin-debian.svg'
picture-uri-dark='file://${XDG_DATA_HOME}/wallpapers/catppuccin-debian.svg'

[org/gnome/desktop/interface]
accent-color='blue'
color-scheme='prefer-dark'
cursor-theme='catppuccin-frappe-dark-cursors'
gtk-theme='Catppuccin-Dark-Frappe'
icon-theme='Adwaita'
EOF
fi

echo "Downloading Kvantum theme..."
git clone --depth 1 "${THEME_GIT_URL}/Kvantum" "${tmp_dir}/Kvantum"

echo "Installing Kvantum theme..."
cp -rfv "${tmp_dir}/Kvantum/themes/catppuccin-frappe-blue" \
  "${XDG_CONFIG_HOME}/Kvantum"

echo "Configuring Kvantum theme..."
cat << EOF > "${XDG_CONFIG_HOME}/Kvantum/kvantum.kvconfig"
[General]
theme=catppuccin-frappe-blue
EOF

cat << EOF > "${XDG_CONFIG_HOME}/env.d/10-kvantum.sh"
# kvantum.sh: configures Qt theme to use Kvantum.
#
# shellcheck shell=sh

if command -v kvantummanager > /dev/null 2>&1; then
  export QT_STYLE_OVERRIDE='kvantum'
fi
EOF

cat << EOF
Installed Catppuccin Frappe with blue accent successfully!

Update the web browser and email client themes and userstyles for consistency:
- https://github.com/catppuccin/firefox
- https://github.com/catppuccin/chrome
- https://github.com/catppuccin/thunderbird
- https://github.com/catppuccin/vimium
- https://github.com/catppuccin/userstyles
- https://catppuccin-userstyles-customizer.uncenter.dev/
EOF
