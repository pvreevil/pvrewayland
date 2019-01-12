#!/bin/sh

sleep 10

while

newsboat -x reload print-unread | awk '{print $1}' >$HOME/.config/sway/conf/newsboat/unread

do sleep 400

done
