#!/bin/sh

WALL=$(ls -A $HOME/Pictures/patterns/ | shuf -n 1)

swaymsg "output * bg $HOME/Pictures/patterns/$WALL tile #2e3440"

