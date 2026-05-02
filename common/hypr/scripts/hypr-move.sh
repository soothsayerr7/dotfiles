#!/usr/bin/env bash

dir="$1"

case "$dir" in
  f) dir_h="r"; dir_v="d"; ;;
  b) dir_h="l"; dir_v="u"; ;;
esac

clients=$(hyprctl clients -j)

win=$(hyprctl activewindow -j)
ws=$(echo "$win" | jq -r '.workspace.id')

if [[ "$ws" -ge 1  && "$ws" -le 9 ]]; then
  x=$(echo "$win" | jq -r '.at[0]')
  col_win_count=$(echo "$clients" | jq -r \
    "[.[] | select(.workspace.id == $ws and .at[0] == $x)] | length")

  if [[ "$col_win_count" == 1 ]]; then
    hyprctl dispatch "hl.dsp.window.move({ direction = '${dir_h}' })"

  else
    hyprctl dispatch "hl.dsp.layout('promote')"

    if [[ "$dir_h" == 'l' ]]; then
      hyprctl dispatch "hl.dsp.layout('swapcol l')"
    fi
  fi

elif [[ "$ws" -ge 11  && "$ws" -le 19 ]]; then
  y=$(echo "$win" | jq -r '.at[1]')
  col_win_count=$(echo "$clients" | jq -r \
    "[.[] | select(.workspace.id == $ws and .at[1] == $y)] | length")

  if [[ "$col_win_count" == 1 ]]; then
    hyprctl dispatch "hl.dsp.window.move({ direction = '${dir_v}' })"

  else
    hyprctl dispatch "hl.dsp.layout('promote')"

    if [[ "$dir_v" == 'u' ]]; then
      hyprctl dispatch "hl.dsp.layout('swapcol l')"
    fi
  fi
fi

