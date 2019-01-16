#!/bin/sh

printf "0">${HOME}/.config/sway/conf/github/unread
sleep 10

TOKEN=$(head -2 ${HOME}/.config/sway/conf/netvar | tail -1)


while

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)
COUNT1=$(cat ~/.config/sway/conf/github/unread)

	if [ "$notifications" -gt 0 ]; then
	    printf "$notifications">${HOME}/.config/sway/conf/github/unread
	else
	    printf "0">${HOME}/.config/sway/conf/github/unread
	fi

COUNT2=$(cat ~/.config/sway/conf/github/unread)

	if [ $notifications -gt 1 ];then
	        not=notifications
	else
        	not=notification
	fi

	if [ $COUNT2 -gt $COUNT1 ]; then
        	notify-send.sh -t 7000 "GitHub" "$notifications unread $not"
	fi

do sleep 60
done
