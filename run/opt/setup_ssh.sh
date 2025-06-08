#!/bin/bash -e
#
# Configures SSH agent forwarding and multiplexing for `CLOUD_HOST`.
#
# Supported systems: Debian, Ubuntu, Fedora, RHEL, MacOS

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

readonly SSH_CONFIG="${HOME}/.ssh/config"
readonly SSHD_CONFIG='/etc/ssh/sshd_config'

echo "Configuring SSH..."

if [[ -f "${SSHD_CONFIG}" ]]; then
  echo "Ensuring agent forwarding is not disabled..."
  sudo sed -i.bak '/^[ \t]*AllowAgentForwarding[ \t]\+no/d' "${SSHD_CONFIG}"
  sudo rm "${SSHD_CONFIG}.bak"
fi

if [[ -n "${CLOUD_HOST}" ]]; then
  echo "Appending SSH multiplexing options to SSH config..."
  cat << EOF >> "${SSH_CONFIG}"

Match host ${CLOUD_HOST}
  # Required for SSH multiplexing:
  ControlMaster auto
  ControlPath ~/.ssh/ctrl-%C
  ControlPersist yes
  ForwardAgent yes  # Only for trusted hosts
EOF
fi

echo "Configured SSH successfully!"
