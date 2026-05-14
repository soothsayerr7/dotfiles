#!/usr/bin/env bash

set -euo pipefail

pkgs_stable=(
  hyprland noctalia hyprqt6engine xdg-desktop-portal-hyprland
)

pkgs_git=(
  hyprland-git noctalia-git hyprqt6engine-git xdg-desktop-portal-hyprland-git
)

pkgs_common=(
  mesa vulkan-radeon
  gtk3 gtk4 qt5-wayland qt6-wayland adw-gtk-theme qt6ct
  alacritty nautilus nautilus-open-any-terminal helium-browser-bin
  mpv-git imv
  xdg-user-dirs xdg-desktop-portal-gtk
  pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
  inter-font noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono ttf-nerd-fonts-symbols
  wl-clipboard cliphist jq hyprshot handlr-regex
)

if command -v paru &> /dev/null; then
  helper='paru'
else
  helper='sudo pacman'
fi

echo '[ 1 ] Stable'
echo '[ 2 ] Git'
read -p 'Hyprland version to install: ' choice

if [[ "$choice" == '1' ]]; then
  pkgs=("${pkgs_stable[@]}" "${pkgs_common[@]}")

elif [[ "$choice" == '2' ]]; then
  pkgs=("${pkgs_git[@]}" "${pkgs_common[@]}")
fi

$helper -S "${pkgs[@]}"

mkdir -p ~/downloads ~/documents ~/pictures/wallpapers ~/pictures/screenshots ~/videos
xdg-user-dirs-update
