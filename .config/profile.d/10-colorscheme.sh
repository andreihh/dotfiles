# colorscheme.sh: sets up color schemes for terminal apps that don't support
# dynamic themes based on the `${COLORSCHEMME}` environment variable.
#
# shellcheck shell=sh

X11_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/X11"

# Load X11 resources explicitly because `xterm` config is not XDG-compliant and
# cannot import files dynamically.
command -v xterm > /dev/null 2>&1 \
  && xrdb -merge "${X11_CONFIG_DIR}/Xresources" \
  && xrdb -merge "${X11_CONFIG_DIR}/Xcolors/${COLORSCHEME}.Xresources"

unset X11_CONFIG_DIR


