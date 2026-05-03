#!/usr/bin/env bash

set -euo pipefail

script_name=$(basename "$0")

if [[ "$#" -lt 2 ]]; then
  echo "Usage: $script_name <device> <partition>"
  echo "Example: $script_name /dev/nvme0n1 1"
  exit 1
fi

taget_dev="$1"
part_num="$2"

mkdir -p /boot/EFI/limine /boot/limine
cp /usr/share/limine/BOOTX64.EFI /boot/EFI/limine

efibootmgr \
  --create \
  --disk "$taget_dev" \
  --part "$part_num" \
  --label "Limine Bootloader" \
  --loader '\EFI\limine\BOOTX64.EFI' \
  --unicode

root_uuid=$(findmnt -no UUID /)

read -p 'Resolution (<width>x<height>): ' resolution

cat <<EOF > /boot/limine/limine.conf
timeout: 15
remember_last_entry: yes

interface_resolution: ${resolution}

interface_branding:

term_palette: 191724;eb6f92;31748f;f6c177;9ccfd8;c4a7e7;ebbcba;e0def4
term_palette_bright: 2a273f;eb6f92;31748f;f6c177;9ccfd8;c4a7e7;ebbcba;e0def4
term_background: 191724
term_foreground: e0def4
term_background_bright: 2a273f
term_foreground_bright: e0def4

/Arch Linux (CachyOS)
    protocol: linux
    path: boot():/vmlinuz-linux-cachyos-bore
    cmdline: root=UUID=${root_uuid} rootflags=subvol=@ rw 
    module_path: boot():/initramfs-linux-cachyos-bore.img

EOF

read -p 'Add entry for Windows? [y/N]: ' confirm

if [[ "$confirm" =~ ^[Yy]([Ee][Ss])?$ ]]; then
  lsblk -o name,label,partuuid
  read -p 'Windows EFI PARTUUID: ' partuuid
  
  cat <<EOF >> /boot/limine/limine.conf
/Windows 11
  protocol: efi
  path: guid(${partuuid}):/EFI/Microsoft/Boot/bootmgfw.efi

EOF
fi
