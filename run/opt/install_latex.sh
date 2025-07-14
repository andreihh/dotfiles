#!/bin/sh
#
# Installs LaTeX.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - MacOS: Homebrew

# Exit if any command fails.
set -e

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

echo "Installing LaTeX..."

command -v apt-get > /dev/null 2>&1 && sudo apt-get install -y texlive-full

command -v dnf > /dev/null 2>&1 \
  && sudo dnf install -y texlive-scheme-full latexmk biber

command -v brew > /dev/null 2>&1 && brew install mactex biber

echo "Installed LaTeX successfully!"
