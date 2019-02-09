#!/bin/sh

pkill requestsb-

export BARPATH=~/.config/sway/conf/

KERNEL=$(uname -r)
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
ac="\"align\":\"center\""
ft="\"full_text\":"
bor="\"border\": \"$colorf\""
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

	{$c \"$gc\",$b \"$color3\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 55,$ft \"$GPU%\"},
        {$c \"$mc\",$b \"$color3\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
        {$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 55,$ft \"$MEM%\"},
	{$c \"$cc\",$b \"$color3\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 55,$ft \"$CPU%\"},
	{$c \"$colorf\",$b \"$color3\",$s,$sw\"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw\"0\",$ac,$mw 55,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $1 $2}')\"},
	{$c \"$colorf\",$b \"$color3\",$s,$sw\"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw\"0\",$ac,$mw 55,$ft \"$(cat $BARPATH/netspeed/speed | awk '{print $3 $4}')\"},
	{$c \"#fafafa\",$b \"#333333\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 55,$ft \"$GH\"},
	{$c \"#cee3f8\",$b \"#ff4500\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 55,$ft \"$RDD\"},
	{$c \"#ffffff\",$b \"#f26522\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 55,$ft \"$RSS\"},
	{$c \"$colorf\",$b \"$color3\",$s,$sw \"0\",$ac,$mw 40,$ft \"$VOLI\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 55,$ft \"$VOL\"},
	{$c \"$colorf\",$b \"$color3\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 210,$ft \"$(date +'%A, %d - %H:%M')\"},
	{$c \"$colorf\",$b \"$color3\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 170,$ft \"$(uptime --pretty | sed 's/up //' | sed 's/\ years\?,/y/' | sed 's/\ days\?,/d/' | sed 's/\ hours\?,\?/h/' | sed 's/\ minutes\?/m/')\"},
	{$c \"#dddfff\",$b \"#54487a\",$s,$sw \"0\",$ac,$mw 40,$ft \"\"},
	{$c \"$colorf\",$b \"$color1\",$s,$sw \"0\",$ac,$mw 170,$ft \"$KERNEL\"},
		]"
do sleep 0.2
done


#                                                          
