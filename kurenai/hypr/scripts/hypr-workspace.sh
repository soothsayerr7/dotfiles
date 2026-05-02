#!/usr/bin/env bash

cmd="$1"
dir="$2"

case "$cmd" in
  focus) cmd_full='hl.dsp.focus'       ;;
  move)  cmd_full='hl.dsp.window.move' ;;
esac

case "$dir" in
  u) delta=-1 ;;
  d) delta=1  ;;
esac

curr_ws=$(hyprctl activeworkspace -j | jq -r '.id')
new_ws=$(( curr_ws + delta ))

if (( (curr_ws - 1) / 10 == (new_ws - 1) / 10 )) && (( new_ws % 10 != 0 )) && (( new_ws > 0 )); then
  hyprctl dispatch "${cmd_full}({ workspace = '${new_ws}' })"
fi
