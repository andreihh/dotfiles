#!/bin/sh
#
# Installs LaTeX.
#
# Supported systems: Debian*, Fedora*, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

echo "Installing LaTeX..."
has-cmd apt-get && install-pkg texlive-full
has-cmd dnf && install-pkg texlive-scheme-full latexmk biber
has-cmd brew && install-pkg mactex biber

echo "Installed LaTeX successfully!"
