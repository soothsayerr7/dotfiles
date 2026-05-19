#!/usr/bin/env bash

window=$(hyprctl activewindow -j)
ws=$(echo "$window" | jq -r '.workspace.id')
fs_state=$(echo "$window" | jq -r '.fullscreenClient')

if [[ ! "$fs_state" -eq 3 ]]; then
  hyprctl dispatch "hl.dsp.layout('colresize 1.0')"
  hyprctl dispatch "hl.dsp.window.fullscreen_state({ internal = 0, client = 3 })"
  hyprctl dispatch "hl.dsp.window.set_prop({ prop = 'border_size', value = 0 })"
  hyprctl eval "hl.workspace_rule({ workspace = $ws, gaps_out = 0 })"

else
  hyprctl dispatch "hl.dsp.window.fullscreen_state({ internal = 0, client = 0 })"
  hyprctl dispatch "hl.dsp.window.set_prop({ prop = 'border_size', value = 2 })"
  hyprctl eval "hl.workspace_rule({ workspace = $ws, gaps_out = 6 })"
fi
