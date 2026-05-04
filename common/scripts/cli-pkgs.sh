#!/usr/bin/env bash

set -euo pipefail

pkgs=(
  7zip zip unzip tealdeer ripgrep fd fzf rsync eza bat openssh zoxide stow libqalculate
)

if command -v paru &> /dev/null; then
  helper='paru'
else
  helper='sudo pacman'
fi

$helper -S ${pkgs[@]}
