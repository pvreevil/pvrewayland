#!/bin/sh
#req jq, galliumHUD
pkill requestsb-

$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/colorvar/colorvar3.sh 
source $BARPATH/alsa/requestsb-alsa.sh
source $BARPATH/moc/requestsb-mocp.sh
bor="\"border\": \"$bg1\""
c="\"color\":"
n="name"
b="\"background\":"
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
	getvol
	mocstate
	printf %s	",[
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$MOC\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 22,$ft \"ram\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$MEM%\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 22,$ft \"cpu\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$CPU%\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 22,$ft \"ssid\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $5 $6}')\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"dw\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"up\"},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 30,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 14'></span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$GH\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 14'>樓</span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$RDD\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 11'></span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$RSS\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 9' rise='2000'>$VOLI</span>\",$mu},
			{$b \"$bg2\",$s,$sw 3,$ac,$mw 24,$ft \"$VOL\",$bor},
			{$b \"$bg1\",$s,$sw 0,$ac,$mw 16,$ft \"<span font_desc='mononoki Nerd Font Mono 13' rise='5100'></span>\",$mu},
			{$b \"$bg2\",$s,$sw 0,$ac,$mw 99,$ft \"$(date +'%A, %d - %H:%M')\",$bor},
		]"
do sleep 0.2
done

