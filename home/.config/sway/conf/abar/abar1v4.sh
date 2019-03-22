#!/bin/sh
#req jq, galliumHUD
pkill requestsb-

$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/alsa/requestsb-alsa.sh
c="\"color\":"
n="name"
b="\"background\":"
s="\"separator\": \"false\""
sw="\"separator_block_width\":"
mw="\"min_width\":"
al="\"align\": \"left\""
ar="\"align\": \"right\""
ac="\"align\": \"center\""
ft="\"full_text\":"
bor="\"border\": \"$colorf\""
mu="\"markup\": \"pango\""
sep="{$s,$sw 0,$ac,$ft \" / \"},"

printf "{ \"version\" : 1 }\n[\n[]\n"

getvar()	{
			NET=$(cat $BARPATH/netspeed/speed)
			MEM=$(free | grep Mem | awk '{print ($3+$6)/$2 * 100}' | awk -F. '{printf "%0.0f\n",$1"."substr($2,1,2)}')
			CPU=$(tail -n 1 /tmp/ghud/cpu | awk -F. '{print $1}')
			GH=$(cat $BARPATH/github/unread)
			RDD=$(cat $BARPATH/reddit/unread)
			RSS=$(cat $BARPATH/newsboat/unread)
}
while
	getvar
	getvol
	printf %s	",[$sep
			{$s,$sw 0,$al,$ft \"ram \"},
			{$s,$sw 0,$ac,$mw 33,$ft \"$MEM%\"},$sep
			{$s,$sw 0,$al,$ft \"cpu \"},
			{$s,$sw 0,$ac,$mw 33,$ft \"$CPU%\"},$sep
			{$s,$sw 0,$al,$ft \"dw \"},
			{$s,$sw 0,$ac,$mw 33,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\"},$sep
			{$s,$sw 0,$al,$ft \"up \"},
			{$s,$sw 0,$ac,$mw 33,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\"},$sep
			{$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 17'></span>\",$mu},
			{$s,$sw 0,$ac,$mw 27,$ft \"$GH\"},$sep
			{$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 17' rise='6200'>樓</span>\",$mu},
			{$s,$sw 0,$ac,$mw 27,$ft \"$RDD\"},$sep
			{$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 13'></span>\",$mu},
			{$s,$sw 0,$ac,$mw 27,$ft \"$RSS\"},$sep
			{$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 12' rise='3000'>$VOLI</span>\",$mu},
			{$s,$sw 0,$ac,$mw 27,$ft \"$VOL\"},$sep
			{$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 15'></span>\",$mu},
			{$s,$sw 0,$ac,$mw 129,$ft \"$(date +'%a, %d - %H:%M')\"},$sep
		]"
do sleep 0.2
done

