#!/usr/bin/env bash

dir="$1"

case "$dir" in
  d) dir_v="r" ;;
  u) dir_v="l" ;;
esac

ws=$(hyprctl activewindow -j | jq -r '.workspace.id')

if [[ "$ws" -ge 1  && "$ws" -le 9 ]]; then
  if [[ "$dir" == 'l' || "$dir" == 'r' ]]; then
    hyprctl dispatch "hl.dsp.layout('swapcol ${dir}')"

  else
    hyprctl dispatch "hl.dsp.window.swap({ direction = '${dir}' })"
  fi

elif [[ "$ws" -ge 11  && "$ws" -le 19 ]]; then
  if [[ "$dir" == 'u' || "$dir" == 'd' ]]; then
    hyprctl dispatch "hl.dsp.layout('swapcol ${dir_v}')"

  else
    hyprctl dispatch "hl.dsp.window.swap({ direction = '${dir}' })"
  fi
fi
