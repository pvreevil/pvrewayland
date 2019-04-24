#!/bin/sh

f=`mocp -Q %file`
p=`dirname "$f"`
imregex="(Folder|folder|front|Front|Cover|cover|art|Art)\\.(jpg|jpeg|png|gif)$"
cover=`ls "$p" | grep -E -i -m1 $imregex`
coverup=`ls "$p/.." | grep -E -i -m1 $imregex`

if [[ -f $p/$cover ]]; then

	cp "$p/$cover" /tmp/cover.png

	notify-send.sh -i /tmp/cover.png -t 9000 "$(mocp -Q "%a - %song")"

elif [[ -f $p/../$coverup ]]; then

	cp "$p/../$coverup" /tmp/cover.png

	notify-send.sh -i /tmp/cover.png -t 9000 "$(mocp -Q "%a - %song")"

else
	notify-send.sh -t 9000 "$(mocp -Q "%a - %song")"
fi
