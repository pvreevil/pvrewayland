#!/bin/sh

printf "0">$HOME/.config/sway/conf/newsboat/unread
sleep 10

while

COUNT1=$(cat ~/.config/sway/conf/newsboat/unread)

newsboat -x reload print-unread | awk '{print $1}'>${HOME}/.config/sway/conf/newsboat/unread

COUNT2=$(cat ~/.config/sway/conf/newsboat/unread)

        if [ $COUNT2 -gt 1 ];then
                not=notifications
        else
                not=notification
        fi

        if [ $COUNT2 -gt $COUNT1 ]; then
                notify-send.sh -t 7000 "Newsboat" "$COUNT2 unread $not"
        fi

do sleep 400

done
