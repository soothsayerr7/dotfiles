#!/usr/bin/env bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo 'ERROR: This script must be run as root.'
  exit 1
fi

pacman -S keyd

systemctl enable --now keyd

cat << EOF | tee /etc/keyd/default.conf > /dev/null
[ids]
*

[main]
capslock = overload(control, esc)

[shift]
numlock = capslock
EOF
