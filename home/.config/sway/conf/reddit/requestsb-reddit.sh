#!/bin/sh

echo "0">${HOME}/.config/sway/conf/reddit/unread
sleep 10

URL=$(head -1 ${HOME}/.config/sway/conf/netvar)
USERAGENT="swaybar/notification-reddit:v1.0 u/pvreevil"

while

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')
COUNT1=$(cat ~/.config/sway/conf/reddit/unread)

	if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
	    echo "$notifications">${HOME}/.config/sway/conf/reddit/unread
	else
	    echo "0">${HOME}/.config/sway/conf/reddit/unread
	fi

COUNT2=$(cat ~/.config/sway/conf/reddit/unread)

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
