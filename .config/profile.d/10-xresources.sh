# xresources.sh: creates `~/.Xresources` file with appropriate `include`s if
# XTerm is installed, or cleans it up otherwise.
#
# shellcheck shell=sh

X11_CONFIGS_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/X11"
XRESOURCES="${X11_CONFIGS_DIR}/Xresources"
XCOLORS="${X11_CONFIGS_DIR}/Xcolors/${COLORSCHEME}.Xresources"

[ ! -f "${XRESOURCES}" ] && unset XRESOURCES
[ ! -f "${XCOLORS}" ] && unset XCOLORS

command -v xterm > /dev/null 2>&1 || rm ~/.Xresources
command -v xterm > /dev/null 2>&1 && cat << EOF > ~/.Xresources
${XRESOURCES:+#include \"${XRESOURCES}\"}
${XCOLORS:+#include \"${XCOLORS}\"}
EOF

unset X11_CONFIGS_DIR
unset XRESOURCES
unset XCOLORS
