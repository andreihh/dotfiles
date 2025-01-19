# colorscheme.sh: sets up colorschemes for terminal apps that don't support
# dynamic themes based on the `${COLORSCHEMME}` environment variable.
#
# shellcheck shell=sh

X11_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/X11"
X11_COLORSCHEME="${X11_CONFIG_DIR}/colorscheme.Xresources"

[ -d "${X11_CONFIG_DIR}" ] && cat << EOF > "${X11_COLORSCHEME}"
! colorscheme.Xresources: auto-generated from \`\${COLORSCHEME}\`.

#include "${X11_CONFIG_DIR}/Xcolors/${COLORSCHEME}.Xresources"
EOF

# Load X11 resources explicitly because `xterm` config is not XDG-compliant.
command -v xterm > /dev/null 2>&1 && xrdb -merge "${X11_CONFIG_DIR}/Xresources"

unset X11_CONFIG_DIR
unset X11_COLORSCHEME
