#!/bin/sh
#req jq, galliumHUD
pkill requestsb-

$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/colorvar3.sh 
source $BARPATH/getcolor.sh
source $BARPATH/alsa/requestsb-alsa.sh
c="\"color\":"
n="name"
b="\"background\":"
s="\"separator\": \"false\""
sw="\"separator_block_width\":"
mw="\"min_width\":"
ac="\"align\": \"center\""
ar="\"align\": \"right\""
ft="\"full_text\":"
bor="\"border\": \"$colorf\""
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
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"ram\"},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$MEM%\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"cpu\"},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$CPU%\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"dw\"},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"up\"},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"<span font_desc='mononoki Nerd Font Mono 20'></span>\",$mu},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$GH\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"<span font_desc='mononoki Nerd Font Mono 20'>樓</span>\",$mu},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$RDD\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"<span font_desc='mononoki Nerd Font Mono 16'></span>\",$mu},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$RSS\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"<span font_desc='mononoki Nerd Font Mono 15'>$VOLI</span>\",$mu},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 3,$ac,$mw 42,$ft \"$VOL\"},
			{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 30,$ft \"<span font_desc='mononoki Nerd Font Mono 19'></span>\",$mu},
			{$c \"$clraf\",$b \"$clra2\",$s,$sw 0,$ac,$mw 180,$ft \"$(date +'%A, %d - %H:%M')\"},
		]"
do sleep 0.2
done

