#!/bin/sh


p=`dirname "$1"`
if [[ -f $p/folder.png ]]; then
	cp "$p/folder.png" /tmp/folder.png
	notify-send.sh -i /tmp/folder.png -t 9000 "$(mocp -Q %a) - $(mocp -Q %song)"
elif [[ -f $p/../folder.png ]]; then
	cp "$p/../folder.png" /tmp/folder.png
	notify-send.sh -i /tmp/folder.png -t 9000 "$(mocp -Q %a) - $(mocp -Q %song)"
else
	notify-send.sh -t 9000 "$(mocp -Q %a) - $(mocp -Q %song)"
fi
