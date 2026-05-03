#!/usr/bin/env bash

set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "ERROR: Must be run as root."
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $(basename "$0") <partition>"
  echo "Example: $(basename "$0") /dev/nvme0n1p2"
  exit 1
fi

target_part="$1"

if [[ ! -b "$target_part" ]]; then
  echo "ERROR: Partition not found."
  exit 1
fi

btrfs subvolume list / | grep snapshots/

read -p "Snapshot to rollback: " name

mount -o subvolid=0 "$target_part" /mnt
snap_path=/mnt/@snapshots/"$name"

if [[ ! -d "$snap_path" ]]; then
  echo "ERROR: Snapshot not found."
  umount -R /mnt
  exit 1
fi

mv /mnt/@ /mnt/@old_$(date +%Y-%m-%d_%H-%M)
btrfs subvolume snapshot -r "$snap_path" /mnt/@
umount -R /mnt
