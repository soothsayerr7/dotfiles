#!/usr/bin/env bash

set -euo pipefail

source helpers.sh

dot_dir="$HOME/dotfiles/dots"
cfg_dir="$HOME/dotfiles/cfg"

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

dfm_sync() {
  cd "$dot_dir"

  for item in *; do
    msg --info "Stowing $item"
    stow -Rd "$dot_dir" -t "$cfg_dir" "$item"
  done
}

main() {
  logo

  case "${1:-}" in
    "sync") dfm_sync ;;
  esac
}

main "$@"
