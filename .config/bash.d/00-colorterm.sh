# colorterm.sh: enables true colors if the terminal has the capability.
#
# Not all terminals set the `${COLORTERM}` variable, even though they support
# true colors. See https://github.com/termstandard/colors.
#
# shellcheck shell=bash

# Check `terminfo` for true color capability.
if [[ "$(tput colors)" -gt 256 ]]; then
  export COLORTERM="truecolor"
fi

# For some terminals, `terminfo` might not advertise true color support, even
# though the terminals have the capability. Enable true colors for terminals
# known to have the capability.
case "${TERM}" in
  # Most `xterm`s support true colors.
  xterm*color*) export COLORTERM="truecolor" ;;
  tmux*)
    # Check if the exported `tmux` capabilities include true colors.
    if [[ $(tmux display -p '#{client_termfeatures}') == *RGB* ]]; then
      export COLORTERM="truecolor"
    fi
    ;;
  *) ;;
esac
