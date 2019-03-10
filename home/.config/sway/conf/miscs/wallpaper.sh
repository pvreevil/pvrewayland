#!/bin/sh

WALL=$(ls -A $HOME/Pictures/Textures/ | shuf -n 1)

swaymsg "output * bg $HOME/Pictures/Textures/$WALL tile #10405b"

