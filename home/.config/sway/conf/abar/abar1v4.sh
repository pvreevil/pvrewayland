#!/bin/sh
#req jq, galliumHUD
pkill requestsb-

$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/colorvar/colorvar5.sh
source $BARPATH/alsa/requestsb-alsa.sh
c="\"color\":\"$fg\""
n="name"
b="\"background\":\"$bg\""
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
	printf %s	",[
			{$c,$b,$s,$sw 0,$al,$ft \"ram \"},
			{$c,$b,$s,$sw 0,$ac,$mw 33,$ft \"$MEM%\"},
			{$c,$b,$s,$sw 0,$al,$ft \"cpu \"},
			{$c,$b,$s,$sw 0,$ac,$mw 33,$ft \"$CPU%\"},
			{$c,$b,$s,$sw 0,$al,$ft \"dw \"},
			{$c,$b,$s,$sw 0,$ac,$mw 33,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\"},
			{$c,$b,$s,$sw 0,$al,$ft \"up \"},
			{$c,$b,$s,$sw 0,$ac,$mw 33,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\"},
			{$c,$b,$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 15' rise='5200'></span>\",$mu},
			{$c,$b,$s,$sw 0,$ac,$mw 27,$ft \"$GH\"},
			{$c,$b,$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 15' rise='6200'>樓</span>\",$mu},
			{$c,$b,$s,$sw 0,$ac,$mw 27,$ft \"$RDD\"},
			{$c,$b,$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 11'></span>\",$mu},
			{$c,$b,$s,$sw 0,$ac,$mw 27,$ft \"$RSS\"},
			{$c,$b,$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 10' rise='2000'>$VOLI</span>\",$mu},
			{$c,$b,$s,$sw 0,$ac,$mw 27,$ft \"$VOL\"},
			{$c,$b,$s,$sw 0,$al,$ft \"<span font_desc='mononoki Nerd Font Mono 13'></span>\",$mu},
			{$c,$b,$s,$sw 0,$ac,$mw 99,$ft \"$(date +'%a, %d - %H:%M')\"}
		]"
do sleep 0.2
done

