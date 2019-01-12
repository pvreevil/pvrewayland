#!/bin/sh

sleep 10

URL=$(head -1 ${HOME}/.config/sway/conf/netvar)
USERAGENT="swaybar/notification-reddit:v1.0 u/pvreevil"

while

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
    echo "$notifications">${HOME}/.config/sway/conf/reddit/unread
else
    echo "0">${HOME}/.config/sway/conf/reddit/unread
fi

do sleep 60

done
