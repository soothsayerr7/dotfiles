#!/usr/bin/env bash

set -euo pipefail

script_name=$(basename $0)

hostname=$(uname -n)

cfg_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
dot_dir="$HOME/.dotfiles"
dfm_dir="$dot_dir/dfm"

ensure_installed() {
  if [[ ! -f "$dfm_dir/dfm.sh" ]]; then
    echo "ERROR: '$script_name' is not in the the proper location."
    echo "Run '$script_name setup' to fix it."
    exit 1
  fi
}

setup_dots() {
  mkdir -p "$dfm_dir"
  cp -p "$0" "$dfm_dir"
  rm "$0"
}

sync_dots() {
  mkdir -p "$dfm_dir/$hostname"
  mkdir -p "$dfm_dir/common"

  local targets=("$cfg_dir" "$dot_dir")

  for target in "${targets[@]}"; do
    stow -vR -d "$dfm_dir" "$hostname" -t "$target"
    stow -vR -d "$dfm_dir" common      -t "$target"
  done
}

edit_dots() {
  local editor="${EDITOR:-nvim}"
  exec $editor "$dot_dir"
}

main() {
  case "${1:-}" in
    'setup')
      setup_dots
      ;;
    'sync')
      ensure_installed
      sync_dots
      ;;
    'edit')
      ensure_installed
      edit_dots
      ;;
    *)
      ensure_installed
      echo "Usage: $script_name {sync|edit [args]|setup}"
      exit 1
      ;;
  esac
}

main "$@"
