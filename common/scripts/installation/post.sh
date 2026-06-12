#!/usr/bin/env bash

set -euo pipefail

read -p 'Hostname: ' hostname
read -p 'Username: ' username
read -p 'CPU (e.G. amd): ' cpu

pacman -S limine efibootmgr "${cpu}-ucode" git btrfs-progs networkmanager man-db terminus-font

ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
hwclock --systohc

for locale in en_IE.UTF-8 en_DK.UTF-8 en_US.UTF-8 pt_BR.UTF-8; do
  sed -i "/^#${locale}/s/^#//" /etc/locale.gen
done

locale-gen

cat <<EOF > /etc/locale.conf
LANG=en_IE.UTF-8
LC_TIME=en_DK.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_CTYPE=pt_BR.UTF-8
EOF

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
