#!/bin/sh
#https://github.com/x70b1/polybar-scripts/tree/master/polybar-scripts/notification-reddit

printf "0">$BARPATH/reddit/unread
sleep 10

URL=$(head -1 ${HOME}/.config/sway/conf/netvar)
USERAGENT="swaybar/notification-reddit:v1.0 u/pvreevil"

while

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')
COUNT1=$(cat $BARPATH/reddit/unread)

	if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
	    printf "$notifications">$BARPATH/reddit/unread
	else
	    printf "0">$BARPATH/reddit/unread
	fi

COUNT2=$(cat $BARPATH/reddit/unread)

	if [ $notifications -gt 1 ];then
		not=notifications
	else
		not=notification
	fi

	if [ $COUNT2 -gt $COUNT1 ]; then
		notify-send.sh -t 7000 "Reddit" "$notifications unread $not"
	fi
do sleep 60
done
