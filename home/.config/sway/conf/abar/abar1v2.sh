#!/bin/sh

pkill requestsb-

export BARPATH=~/.config/sway/conf/

$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/abar/colorsnaturalist.sh 
source $BARPATH/abar/getcolor.sh
source $BARPATH/alsa/requestsb-alsa.sh
c="\"color\":"
n="name"
b="\"background\":"
s="\"separator\": \"false\""
sw="\"separator_block_width\":"
mw="\"min_width\":"
ac="\"align\": \"center\""
ft="\"full_text\":"
bor="\"border\": \"$colorf\""
mu="\"markup\": \"pango\""
rarrow="{$c \"$color4\",$b \"$color1\",$s,$sw \"-2\",$ac,$mu,$ft \"<span font_desc='GoMono Nerd Font Mono 22'></span>\"},"
rarrow2="{$c \"$color4\",$b \"$color1\",$s,$sw \"-2\",$ac,$mu,$ft \"<span font_desc='GoMono Nerd Font Mono 22'></span>\"},"
larrow="{$c \"$color4\",$b \"$color1\",$s,$sw \"-2\",$ac,$mu,$ft \"<span font_desc='GoMono Nerd Font Mono 22'></span>\"},"
echo '{ "version" : 1 }'
echo '['
echo '[]'

getvar()	{
	NET=$(cat $BARPATH/netspeed/speed)
	MEM=$(free | grep Mem | awk '{print ($3+$6)/$2 * 100}' | awk -F. '{printf "%0.0f\n",$1"."substr($2,1,2)}')
	CPU=$(tail -n 1 /tmp/ghud/cpu | awk -F. '{print $1}')
	GPU=$(tail -n 1 /tmp/ghud/GPU_load)
	GH=$(cat $BARPATH/github/unread)
	RDD=$(cat $BARPATH/reddit/unread)
	RSS=$(cat $BARPATH/newsboat/unread)
}
while
	getvar
	getcolor
	getvol
	printf %s	",[

	$larrow {$c \"$gc\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 40,$ft \"$GPU%\"},$rarrow2
        {$c \"$mc\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
        {$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 40,$ft \"$MEM%\"},$rarrow2
	{$c \"$cc\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 40,$ft \"$CPU%\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw\"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw\"0\",$ac,$mw 55,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw\"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw\"0\",$ac,$mw 55,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 30,$ft \"$GH\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 30,$ft \"$RDD\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 30,$ft \"$RSS\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"$VOLI\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 30,$ft \"$VOL\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 120,$ft \"$(date +'%A, %d')\"},$rarrow2
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 30,$ft \"\"},$rarrow
	{$c \"$colorf\",$b \"$color4\",$s,$sw \"0\",$ac,$mw 40,$ft \"$(date +'%H:%M')\"},
	{$c \"$color4\",$b \"$00000000\",$s,$sw \"-2\",$ac,$mu,$ft \"<span font_desc='GoMono Nerd Font Mono 22'></span>\"},
		]"
do sleep 0.2
done


#                                                          
