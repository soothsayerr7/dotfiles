#!/usr/bin/env bash

set -euo pipefail

lsblk -o NAME
read -p 'Target device (e.G. /dev/nvme0n1): ' target_dev

read -p 'Wipe device? [y/N]: ' wipe

if [[ "$wipe" =~ ^[Yy]([Ee][Ss])?$ ]]; then
  wipefs -a "$target_dev"
  parted -s "$target_dev" mklabel gpt
fi

parted -s "$target_dev" unit mib print

read -p 'EFI partition number: ' efi_part_num

boot_part_num=$(( efi_part_num + 1 ))
root_part_num=$(( boot_part_num + 1 ))

read -p 'EFI partition start: ' efi_start

boot_start=$(( efi_start + 512 ))
root_start=$(( boot_start + 1024 ))

read -p 'ROOT partition size in MiB: ' root_size

root_end=$(( root_start + root_size ))

parted -s "$target_dev" mkpart "ARCHEFI" fat32 "${efi_start}MiB" "${boot_start}MiB"
parted -s "$target_dev" set "$efi_part_num" esp on

parted -s "$target_dev" mkpart "ARCHBOOT" fat32 "${boot_start}MiB" "${root_start}MiB"

parted -s "$target_dev" mkpart "ARCH" btrfs "${root_start}MiB" "${root_end}MiB"

partprobe "$target_dev"

get_part() {
  local dev=$1
  local num=$2

  if [[ $dev =~ [0-9]$ ]]; then
    echo "${dev}p${num}"
  else
    echo "${dev}${num}"
  fi
}

efi_part=$(get_part "$target_dev" "$efi_part_num") 
boot_part=$(get_part "$target_dev" "$boot_part_num") 
root_part=$(get_part "$target_dev" "$root_part_num") 

mkfs.fat -F 32 -n ARCHEFI "$efi_part"
mkfs.fat -F 32 -n ARCHBOOT "$boot_part"
mkfs.btrfs -f -L ARCH "$root_part"

mount "$root_part" /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@machines
btrfs subvolume create /mnt/@portables

umount -R /mnt

mount -o noatime,compress=zstd,subvol=@ "$root_part" /mnt

mkdir -p /mnt/home /mnt/.snapshots /mnt/boot \
  /mnt/var/log /mnt/var/lib/machines /mnt/var/lib/portables

mount -o noatime,compress=zstd,subvol=@home "$root_part" /mnt/home
mount -o noatime,compress=zstd,subvol=@snapshots "$root_part" /mnt/.snapshots
mount -o noatime,compress=zstd,subvol=@log "$root_part" /mnt/var/log
mount -o noatime,compress=zstd,subvol=@machines "$root_part" /mnt/var/lib/machines
mount -o noatime,compress=zstd,subvol=@portables "$root_part" /mnt/var/lib/portables

mount "$boot_part" /mnt/boot

mkdir -p /mnt/boot/efi

mount "$efi_part" /mnt/boot/efi
