#!/usr/bin/env bash

set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "ERROR: Must be run as root."
  exit 1
fi

name=$(date +%Y-%m-%d_%H-%M)
tmp=/tmp/snapshot
config=/boot/limine/limine.conf

btrfs subvolume snapshot -r / /.snapshots/"$name"

CMDLINE=$(sed 's/subvol=[^ ]*/subvol=@snapshots\/'"$name"'/' /proc/cmdline)

cat <<EOF > ${tmp}
    //${name}
        protocol: linux
        path: boot():/vmlinuz-linux-cachyos-bore
        cmdline: ${CMDLINE}
        module_path: boot():/initramfs-linux-cachyos-bore.img

EOF

if grep -qF '/Snapshots' "$config"; then
  sed '/\/Snapshots/r '"$tmp" "$config" > "$config".tmp && mv "$config".tmp "$config"

else
  printf "/Snapshots\n" >> "$config" && cat "$tmp" >> "$config"
fi
