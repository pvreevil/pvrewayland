#!/bin/sh
#https://github.com/x70b1/polybar-scripts/tree/master/polybar-scripts/notification-github

printf "0">$BARPATH/github/unread
sleep 10

TOKEN=$(head -2 $BARPATH/netvar | tail -1)


while

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)
COUNT1=$(cat $BARPATH/github/unread)

	if [ "$notifications" -gt 0 ]; then
	    printf "$notifications">$BARPATH/github/unread
	else
	    printf "0">$BARPATH/github/unread
	fi

COUNT2=$(cat $BARPATH/github/unread)

	if [ $notifications -gt 1 ];then
	        not=notifications
	else
        	not=notification
	fi

	if [ $COUNT2 -gt $COUNT1 ]; then
        	notify-send.sh -i $BARPATH/github/gh.png -t 14000 "GitHub" "$notifications unread $not"
	fi

do sleep 60
done
