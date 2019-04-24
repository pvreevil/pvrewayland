#!/bin/sh

printf "0">$BARPATH/newsboat/unread
sleep 10

while

COUNT1=$(cat $BARPATH/newsboat/unread)

NUMBER=$(newsboat -x reload print-unread | awk '{print $1}')

printf $NUMBER>$BARPATH/newsboat/unread

COUNT2=$(cat $BARPATH/newsboat/unread)

        if [ $COUNT2 -gt 1 ];then
                not=notifications
        else
                not=notification
        fi

        if [ $COUNT2 -gt $COUNT1 ]; then
                notify-send.sh -i $BARPATH/newsboat/rss.png -t 7000 "$COUNT2 unread $not"
        fi

do sleep 900

done
