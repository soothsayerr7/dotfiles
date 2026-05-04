#!/usr/bin/env bash

set -euo pipefail

script_name=$(basename "$0")

if [[ $# -eq 0 ]]; then
  echo "Usage: $script_name <hostname> <cpu>"
  echo "Example: $script_name arch amd"
  exit 1
fi

hostname="$1"
cpu="$2"
username='ryo'
locale='en_GB.UTF-8'
timezone='America/Fortaleza'

pacman -S limine efibootmgr ${cpu}-ucode git btrfs-progs networkmanager man-db terminus-font

ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime
hwclock --systohc

sed -i "/^#${locale}/s/^#//" /etc/locale.gen
locale-gen
echo "LANG=${locale}" > /etc/locale.conf

cat <<EOF > /etc/vconsole.conf
KEYMAP=us
FONT=ter-128n
EOF

echo "$hostname" > /etc/hostname

cat <<EOF > /etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.1.1    ${hostname}.localdomain    ${hostname}
EOF

echo 'Password for root:'
passwd

chsh -s /usr/bin/fish

useradd -mG wheel -s /usr/bin/fish ${username}
echo "Password for ${username}:"
passwd "$username"

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

systemctl enable NetworkManager
