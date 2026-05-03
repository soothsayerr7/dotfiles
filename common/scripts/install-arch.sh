#!/usr/bin/env bash

set -euo pipefail

pacstrap -K /mnt base base-devel linux-cachyos-bore linux-firmware fish neovim
genfstab -U /mnt > /mnt/etc/fstab
