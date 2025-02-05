#!/bin/bash -e
#
# Configures SSH on Linux servers, or on Linux or MacOS clients.

readonly SSH_CONFIG="${HOME}/.ssh/config"
readonly SSHD_CONFIG="/etc/ssh/sshd_config"
readonly X11_OPTION_PATTERN='#?X11Forwarding .*'
readonly SED_X11_OPTION_PATTERN="s/${X11_OPTION_PATTERN}/X11Forwarding yes/"

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
  echo "Configuring server SSHD..."

  echo "Installing 'xauth'..."
  sudo apt install -y xauth

  echo "Enabling X11 forwarding in 'sshd' config..."
  if grep -Ex "${X11_OPTION_PATTERN}" "${SSHD_CONFIG}"; then
    sudo sed -i -E "${SED_X11_OPTION_PATTERN}" "${SSHD_CONFIG}"
  else
    echo "X11Forwarding yes" | sudo tee -a "${SSHD_CONFIG}"
  fi

  echo "Configured server SSH successfully!"
fi

if [[ -n "${hosts_pattern}" ]]; then
  echo "Configuring client SSH for trusted hosts..."

  echo "Appending X11 forwarding and SSH multiplexing options to SSH config..."
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
