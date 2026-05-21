#!/usr/bin/env bash

set -euo pipefail

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

DOTFILES="$HOME/test_folder/dotfiles"

dfm_loop() {
  local hostname=$(hostnamectl hostname)

  local dirs=(
    "$DOTFILES"
    "$DOTFILES/@home"
    "$DOTFILES/@$hostname"
    "$DOTFILES/@$hostname/@home"
  )

  declare -ag DOT_PATHS

  for dir in "${dirs[@]}"; do
    [[ -d "$dir" ]] || continue

    for path in "$dir"/*; do
      [[ -e "$path" ]] || continue

      local entry=$(basename "$path")

      [[ "$entry" == @* ]] && continue

      DOT_PATHS+=("$path")
    done
  done
}

dfm_sync() {
  dfm_loop

  local home_dir="$HOME/test_folder"
  local cfg_dir="$home_dir/config"

  for path in "${DOT_PATHS[@]}"; do
    local src_entry=$(basename "$path")
    local tgt_entry="${src_entry/#dot-/.}"

    local rpath="${path#$DOTFILES/}"
    msg --info "Linking $rpath..."

    if [[ "$rpath" == *@home* ]]; then
      ln -sfn "$path" "$home_dir/$tgt_entry"
    else
      ln -sfn "$path" "$cfg_dir/$tgt_entry" 
    fi
  done
}

action=${1:-"sync"}

main() {
  logo

  case "$action" in
    "sync") dfm_sync ;;
  esac
}

main "$@"
