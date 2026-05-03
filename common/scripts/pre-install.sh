#!/usr/bin/env bash

set -euo pipefail

script_name=$(basename "$0")

if [ -z "$1" ]; then
  echo "Usage: $script_name <device>"
  echo "Example: $script_name /dev/nvme0n1"
  exit 1
fi

target_dev="$1"

if [[ ! -b "$target_dev" ]]; then
  echo "ERROR: Device $target_dev not found."
  exit 1
fi

echo "Targeting device: $target_dev."
echo "WARNING: ALL DATA ON $target_dev WILL BE ERASED!"
read -p 'Type YES to confirm: ' confirm

if [[ ! "$confirm" =~ ^[Yy]([Ee][Ss])?$ ]]; then
  echo 'Aborting. No changes were made.'
  exit 1
fi

wipefs -a "$target_dev"

parted -s "$target_dev" mklabel gpt

parted -s "$target_dev" mkpart "ARCHBOOT" fat32 1MiB 1537MiB
parted -s "$target_dev" set 1 esp on

parted -s "$target_dev" mkpart "ARCH" btrfs 1537MiB 953857MiB

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

boot_part=$(get_part "$target_dev" 1) 
root_part=$(get_part "$target_dev" 2) 

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
