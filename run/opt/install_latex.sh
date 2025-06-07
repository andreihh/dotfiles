#!/bin/bash -e
#
# Installs LaTeX.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS
# Dependencies:
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing LaTeX..."

command -v apt-get &> /dev/null && sudo apt-get install -y texlive-full

command -v dnf &> /dev/null \
  && sudo dnf install -y texlive-scheme-full latexmk biber

command -v brew &> /dev/null && brew install mactex biber

echo "Installed LaTeX successfully!"
