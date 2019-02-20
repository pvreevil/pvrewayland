#!/bin/sh

pkill requestsb-

$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &
#  	▙▜   ▛     ▟ ▚  ▞  
#JSON
source $BARPATH/colorvar.sh 
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

rarrow2="{$c \"$clra2\",$b \"$clra1\",$s,$sw \"0\",$mu,$ft \"<span font_desc='mononoki Nerd Font Mono 14' rise='6500'></span>\"},"
rarrow="{$c \"$clra2\",$b \"#00000000\",$s,$sw \"10\",$ac,$mu,$ft \"<span font_desc='mononoki Nerd Font Mono 16' rise='5130'>▛</span>\"},"
larrow="{$c \"$color4\",$b \"$color1\",$s,$sw \"0\",$ac,$mu,$ft \"<span font_desc='mononoki Nerd Font Mono 16' rise='5130'>▟</span>\"},"
larrow2="{$c \"$clra1\",$b \"#00000000\",$s,$sw \"0\",$ac,$mu,$ft \"<span font_desc='mononoki Nerd Font Mono 16' rise='5130'>▟</span>\"},"
#icon sample {$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mu, $mw 20,$ft \"<span font_desc='mononoki Nerd Font Mono 13'></span>\"},

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

{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 40,$ft \"ram\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$MEM%\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 40,$ft \"cpu\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$CPU%\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 40,$ft \"dw\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mw 40,$ft \"up\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mu, $mw 40,$ft \"<span font_desc='mononoki Nerd Font Mono 20'></span>\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$GH\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mu, $mw 40,$ft \"<span font_desc='mononoki Nerd Font Mono 20'>樓</span>\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$RDD\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mu, $mw 40,$ft \"<span font_desc='mononoki Nerd Font Mono 16'></span>\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$RSS\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mu, $mw 40,$ft \"<span font_desc='mononoki Nerd Font Mono 15'>$VOLI</span>\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 7,$ac,$mw 40,$ft \"$VOL\"},
{$c \"$clraf\",$b \"$clra1\",$s,$sw 0,$ac,$mu, $mw 40,$ft \"<span font_desc='mononoki Nerd Font Mono 19'></span>\"},$rarrow2
{$c \"$clraf\",$b \"$clra2\",$s,$sw 0,$ac,$mw 200,$ft \"$(date +'%A, %d - %H:%M')\"},
		]"
do sleep 0.2
done


#                                                          

#樓
