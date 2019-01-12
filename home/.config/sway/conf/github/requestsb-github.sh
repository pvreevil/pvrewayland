#!/bin/sh

sleep 10

TOKEN=$(head -2 ${HOME}/.config/sway/conf/netvar | tail -1)

while

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "$notifications">${HOME}/.config/sway/conf/github/unread
else
    echo "0">${HOME}/.config/sway/conf/github/unread
fi

do sleep 60

done
