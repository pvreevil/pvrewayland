#!/bin/sh
#req jq, galliumHUD
pkill requestsb-

$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/colorvar/colorvar1.sh 
source $BARPATH/colorvar/getcolor.sh
source $BARPATH/alsa/requestsb-alsa.sh
bor="\"border\": \"$bg1\""
c="\"color\":"
n="name"
b="$bor,\"background\":"
s="\"separator\": \"false\""
sw="\"separator_block_width\":"
mw="\"min_width\":"
ac="\"align\": \"center\""
ar="\"align\": \"right\""
ft="\"full_text\":"
mu="\"markup\": \"pango\""

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
	getcolor
	getvol
	printf %s	",[
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 22,$ft \"ram\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$MEM%\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 22,$ft \"cpu\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$CPU%\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"dw\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"up\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 14'></span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$GH\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 14'>樓</span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$RDD\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 11'></span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$RSS\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 9'>$VOLI</span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$VOL\"},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 13'></span>\",$mu},
			{$b \"$bg2\",$s,$sw 0,$ac,$mw 99,$ft \"$(date +'%A, %d - %H:%M')\"},
		]"
do sleep 0.2
done

