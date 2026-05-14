#!/usr/bin/env bash

font="$1"
font_mono="$2"
font_size="$3"
terminal="$4"

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

gsettings set org.gnome.desktop.interface font-name "${font} ${font_size}"
gsettings set org.gnome.desktop.interface monospace-font-name "${font_mono} ${font_size}"

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal "$terminal"
