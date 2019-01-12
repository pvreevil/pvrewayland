#!/bin/env bash

declare -r filter='
def find_focused_node:
	if .focused then . else (if .nodes then (.nodes | .[] | find_focused_node) else empty end) end;
def format_rect:
	"\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)";
find_focused_node | format_rect
'
take_shot() {
	grim "$@" $HOME/Pictures/Screenshots/screenshot_$(date +%Y_%m_%d_%Hh%Mm%Ss).png
}
take_shot -g "$(swaymsg --type get_tree --raw | jq --raw-output "${filter}")"
