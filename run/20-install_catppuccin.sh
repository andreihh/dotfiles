#!/bin/bash -e
#
# Installs Catppuccin themes.
#
# Configure the flavor by setting the `THEME` variable to one of:
# - `catppuccin-frappe` (default)
# - `catppuccin-macchiato`
# - `catppuccin-mocha`
#
# Setting `THEME` to any other non-empty value will skip the theme installation.
#
# See https://catppuccin.com.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies: `git`, `wget`

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly THEME_GIT_URL='https://github.com/catppuccin'
readonly THEME_CURSORS_URL="${THEME_GIT_URL}/cursors/releases/latest/download"

case "${THEME:-"catppuccin-frappe"}" in
  catppuccin-frappe)
    flavor='frappe'
    flavor_camelcase='Frappe'
    gtk_installer_args=(--tweaks frappe)
    ;;
  catppuccin-macchiato)
    flavor='macchiato'
    flavor_camelcase='Macchiato'
    gtk_installer_args=(--tweaks macchiato)
    ;;
  catppuccin-mocha)
    flavor='mocha'
    flavor_camelcase='Mocha'
    gtk_installer_args=()
    ;;
  *) echo "Theme '${THEME}' not supported, installation skipped!" && exit 0 ;;
esac

echo "Installing Catppuccin ${flavor_camelcase} theme..."

echo "Creating temporary Catppuccin installation directory..."
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/catppuccin.XXXXXXXXX")"

echo "Creating application theme directories..."
for app in 'alacritty' 'fzf' 'bat' 'cava'; do
  mkdir -p "${XDG_CONFIG_HOME}/${app}/themes"
done

echo "Downloading Alacritty theme..."
wget -O "${XDG_CONFIG_HOME}/alacritty/themes/catppuccin-${flavor}.toml" \
  "${THEME_GIT_URL}/alacritty/raw/main/catppuccin-${flavor}.toml"

echo "Configuring Alacritty theme..."
cat << EOF > "${XDG_CONFIG_HOME}/alacritty/theme.toml"
# theme: configures Alacritty theme.
#
# Alacritty config cannot import dynamic files.

[general]
import = ["themes/catppuccin-${flavor}.toml"]
EOF

echo "Configuring Ghostty theme..."
cat << EOF > "${XDG_CONFIG_HOME}/ghostty/theme"
# theme: configures Ghostty theme.
#
# Ghostty config cannot set dynamic themes.

theme = "catppuccin-${flavor}"
EOF

echo "Downloading 'fzf' theme..."
wget -O "${XDG_CONFIG_HOME}/fzf/themes/catppuccin-${flavor}.sh" \
  "${THEME_GIT_URL}/fzf/raw/main/themes/catppuccin-fzf-${flavor}.sh"

echo "Downloading 'bat' theme..."
wget -O "${XDG_CONFIG_HOME}/bat/themes/catppuccin-${flavor}.tmTheme" \
  "${THEME_GIT_URL}/bat/raw/main/themes/Catppuccin ${flavor_camelcase}.tmTheme"

if command -v batcat &> /dev/null; then
  echo "Updating 'batcat' cache..."
  batcat cache --build
elif command -v bat &> /dev/null; then
  echo "Updating 'bat' cache..."
  bat cache --build
fi

echo "Downloading 'cava' theme..."
wget -O "${XDG_CONFIG_HOME}/cava/themes/catppuccin-${flavor}.cava" \
  "${THEME_GIT_URL}/cava/raw/main/themes/${flavor}.cava"

echo "Configuring 'cava' theme..."
cat << EOF > "${XDG_CONFIG_HOME}/cava/config"
# config: configures cava theme.
#
# Cava config cannot set dynamic themes.
[color]
theme = 'catppuccin-${flavor}'
EOF

# TODO: remove workaround after 'cava' 0.10.5 is released.
cp -fv "${XDG_CONFIG_HOME}/cava/themes/catppuccin-${flavor}.cava" \
  "${XDG_CONFIG_HOME}/cava/config"

echo "Configuring shell theme..."
cat << EOF > "${XDG_CONFIG_HOME}/profile.d/10-theme.sh"
# theme.sh: configures shell theme.
#
# shellcheck shell=sh

export TMUX_THEME='catppuccin-${flavor}'
export NVIM_THEME='catppuccin-${flavor}'
export VIM_THEME='catppuccin_${flavor}'
export BAT_THEME='catppuccin-${flavor}'

fzf_theme="\${XDG_CONFIG_HOME:-\${HOME}/.config}/fzf/themes/catppuccin-${flavor}.sh"
if [ -f "\${fzf_theme}" ]; then
  . "\${fzf_theme}"
fi
unset fzf_theme
EOF

echo "Downloading cursor theme..."
wget -P "${tmp_dir}/cursors" \
  "${THEME_CURSORS_URL}/catppuccin-${flavor}-dark-cursors.zip"

echo "Unpacking cursor theme..."
sudo unzip -od /usr/share/icons/ "${tmp_dir}/cursors/*.zip"

echo "Downloading GTK theme..."
# https://github.com/catppuccin/gtk was archived, so download an alternative.
git clone --depth 1 https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme \
  "${tmp_dir}/gtk"

echo "Installing GTK theme..."
"${tmp_dir}/gtk/themes/install.sh" \
  --dest "${XDG_DATA_HOME}/themes" \
  --libadwaita --tweaks outline "${gtk_installer_args[@]}"

command -v gnome-shell &> /dev/null \
  && echo "Configuring GNOME theme..." \
  && dconf load / << EOF
[org/gnome/shell/extensions/user-theme]
name='Catppuccin-Dark-${flavor_camelcase}'

[org/gnome/desktop/background]
picture-uri='file://${XDG_DATA_HOME}/wallpapers/catppuccin-debian.svg'
picture-uri-dark='file://${XDG_DATA_HOME}/wallpapers/catppuccin-debian.svg'

[org/gnome/desktop/interface]
accent-color='blue'
color-scheme='prefer-dark'
cursor-theme='catppuccin-${flavor}-dark-cursors'
gtk-theme='Catppuccin-Dark-${flavor_camelcase}'
icon-theme='Adwaita'
EOF

echo "Downloading Kvantum theme..."
git clone --depth 1 "${THEME_GIT_URL}/Kvantum" "${tmp_dir}/Kvantum"

echo "Installing Kvantum theme..."
cp -rfv "${tmp_dir}/Kvantum/themes/catppuccin-${flavor}-lavender" \
  "${XDG_CONFIG_HOME}/Kvantum"

echo "Configuring Kvantum theme..."
cat << EOF > "${XDG_CONFIG_HOME}/Kvantum/kvantum.kvconfig"
[General]
theme=catppuccin-${flavor}-lavender
EOF

cat << EOF > "${XDG_CONFIG_HOME}/profile.d/10-kvantum.sh"
# kvantum.sh: configures Qt theme to use Kvantum.
#
# shellcheck shell=sh

if command -v kvantummanager > /dev/null 2>&1; then
  export QT_STYLE_OVERRIDE='kvantum'
fi
EOF

echo "Cleaning up Catppuccin installation..."
rm -rf "${tmp_dir}"

cat << EOF
Installed Catppuccin ${flavor_camelcase} successfully!

Consider updating the web browser theme and userstyles for consistency:
- https://github.com/catppuccin/firefox
- https://github.com/catppuccin/chrome
- https://github.com/catppuccin/vimium
- https://github.com/catppuccin/userstyles
- https://catppuccin-userstyles-customizer.uncenter.dev/
EOF
