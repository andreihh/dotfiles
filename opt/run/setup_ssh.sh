#!/bin/bash -e
#
# Configures SSH on Linux servers, or on Linux or MacOS clients.

readonly SSH_CONFIG="${HOME}/.ssh/config"
readonly SSHD_CONFIG="/etc/ssh/sshd_config"

usage() {
  cat << EOF
Usage: $0 [-h] [-s] [-c <trusted-hosts-pattern>]

  -s  Configure SSH server.
  -c  Configure SSH client with the given pattern of trusted hosts.
  -h  Print this message and exit.
EOF
}

while getopts 'sc:h' option; do
  case "${option}" in
    h) usage && exit 0 ;;
    s) server='-s' ;;
    c) hosts_pattern="${OPTARG//;/ }" ;;
    *) usage && exit 1 ;;
  esac
done

if [[ -n "${server}" ]]; then
  echo "Configuring server SSH..."

  echo "Ensuring agent forwarding is not disabled..."
  sudo sed -i -e '/^AllowAgentForwarding no/ s/^#*/#/' "${SSHD_CONFIG}"

  echo "Configured server SSH successfully!"
fi

if [[ -n "${hosts_pattern}" ]]; then
  echo "Configuring client SSH for trusted hosts..."

  echo "Appending SSH multiplexing options to SSH config..."
  cat << EOF >> "${SSH_CONFIG}"

Match host ${hosts_pattern}
  # Required for SSH multiplexing:
  ControlMaster auto
  ControlPath ~/.ssh/ctrl-%C
  ControlPersist yes
  ForwardAgent yes  # Only for trusted hosts
EOF

  echo "Configured client SSH successfully!"
fi
