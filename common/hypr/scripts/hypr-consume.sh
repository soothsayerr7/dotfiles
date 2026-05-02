#!/usr/bin/env bash

dir="$1"

case "$dir" in
  f) dir_h="r"; opp_h="l"; dir_v="d"; opp_v="u" ;;
  b) dir_h="l"; opp_h="r"; dir_v="u"; opp_v="d" ;;
esac

win=$(hyprctl activewindow -j)
ws=$(echo "$win" | jq -r '.workspace.id')
addr=$(echo "$win" | jq -r '.address')

if [[ "$ws" -ge 1  && "$ws" -le 9 ]]; then
  hyprctl dispatch "hl.dsp.focus({ direction = '${dir_h}' })"

  new_addr=$(hyprctl activewindow -j | jq -r '.address')

  if [[ "$addr" != "$new_addr" ]]; then
    hyprctl dispatch "hl.dsp.window.move({ direction = '${opp_h}' })"
    hyprctl dispatch "hl.dsp.focus({ direction = 'u' })"
  fi

elif [[ "$ws" -ge 11  && "$ws" -le 19 ]]; then
  hyprctl dispatch "hl.dsp.focus({ direction = '${dir_v}' })"

  new_addr=$(hyprctl activewindow -j | jq -r '.address')

  if [[ "$addr" != "$new_addr" ]]; then
    hyprctl dispatch "hl.dsp.window.move({ direction = '${opp_v}' })"
    hyprctl dispatch "hl.dsp.focus({ direction = 'l' })"
  fi
fi
