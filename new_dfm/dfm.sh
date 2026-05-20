#!/usr/bin/env bash

set -e

source helpers.sh

logo() {
  msg
  msg -2 "      █████    ██████                 "
  msg -2 "     ▒▒███    ███▒▒███                "
  msg -2 "   ███████   ▒███ ▒▒▒  █████████████  "
  msg -2 "  ███▒▒███  ███████   ▒▒███▒▒███▒▒███ "
  msg -2 " ▒███ ▒███ ▒▒▒███▒     ▒███ ▒███ ▒███ "
  msg -2 " ▒███ ▒███   ▒███      ▒███ ▒███ ▒███ "
  msg -2 " ▒▒████████  █████     █████▒███ █████"
  msg -2 "  ▒▒▒▒▒▒▒▒  ▒▒▒▒▒     ▒▒▒▒▒ ▒▒▒ ▒▒▒▒▒ "
  msg -b "  dfm.sh - dotfiles manager"
  msg
}

hostname=$(hostnamectl hostname)

source_dir="$HOME/new_dfm/dots"
target_dir="$HOME/new_dfm/cfg"

dfm_sync() {
  declare -A skip

  skip["dfm"]=1
  skip["home"]=1
  skip["kurenai"]=1
  skip["seiryu"]=1

  for package_path in "$source_dir"/*; do
    package=$(basename "$package_path")

    if [[ -z "${skip[$package]}" ]]; then
      msg --info "Linking $package..."

      ln -sfn "$package_path" "$target_dir/$package"

      if [[ -L "$target_dir/$package" ]]; then
        msg --done "$package linked"
      fi
    fi
  done
}

main() {
  logo

  case "${1:-}" in
    "sync") dfm_sync ;;
  esac
}

main "$@"
