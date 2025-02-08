#!/bin/bash -e
#
# Installs OpenJDK for Linux or MacOS systems.
#
# Requirements:
# - MacOS: Homebrew

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing OpenJDK..."

# Use Homebrew if available.
if command -v brew &> /dev/null; then
  brew install openjdk
else
  sudo apt install -y openjdk-21-jdk
fi

echo "Installed OpenJDK successfully!..."
