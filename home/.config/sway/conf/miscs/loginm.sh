#!/bin/sh

notify-send.sh -t 7000 "Last login: $(lastlog -u $USER | tail -1 | awk '{print $4,$5,$6}')" "Welcome Back Senpai"
