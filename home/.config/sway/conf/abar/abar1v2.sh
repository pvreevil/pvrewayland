#!/bin/sh

pkill requestsb-

export BARPATH=~/.config/sway/conf/

KERNEL=$(uname -r)
$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/abar/vintagecolors.sh 
source $BARPATH/abar/getcolor.sh
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
	CPU=$(tail -n 1 /tmp/ghud/cpu  | awk -F. '{print $1}')
	GPU=$(tail -n 1 /tmp/ghud/GPU_load)
	GH=$(cat $BARPATH/github/unread)
	RDD=$(cat $BARPATH/reddit/unread)
	RSS=$(cat $BARPATH/newsboat/unread)
}
while
	getvar
	getcolor
	printf %s	",[

	{$c \"$colorb\",$b \"$gc\",$bor,$s,$sw \"7\",$ac,$mw 80,$ft \" $GPU%\"},
        {$c \"$colorb\",$b \"$mc\",$bor,$s,$sw \"7\",$ac,$mw 80,$ft \" $MEM%\"},
	{$c \"$colorb\",$b \"$cc\",$bor,$s,$sw \"7\",$ac,$mw 80,$ft \" $CPU%\"},
	{$c \"$color7\",$b \"$colorb\",$bor,$s,$sw\"7\",$ac,$mw 210,$ft \" $NET \"},
	{$c \"$color7\",$b \"$colorb\",$bor,$s,$sw \"7\",$ac,$mw 80,$ft \"$($BARPATH/alsa/requestsb-alsa.sh)\"},
	{$c \"#fafafa\",$b \"#333333\",$bor,$s,$sw \"7\",$ac,$mw 80,$ft \" $GH\"},
	{$c \"#cee3f8\",$b \"#ff4500\",$bor,$s,$sw \"7\",$ac,$mw 80,$ft \" $RDD\"},
	{$c \"#ffffff\",$b \"#f26522\",$bor,$s,$sw \"7\",$ac,$mw 80,$ft \" $RSS\"},
	{$c \"$color7\",$b \"$colorb\",$bor,$s,$sw \"7\",$ac,$mw 240,$ft \"$(date +'  %A, %d-%H:%M')\"},
	{$c \"$color7\",$b \"$colorb\",$bor,$s,$sw \"7\",$ac,$mw 210,$ft \" $(uptime --pretty | sed 's/up //' | sed 's/\ years\?,/y/' | sed 's/\ days\?,/d/' | sed 's/\ hours\?,\?/h/' | sed 's/\ minutes\?/m/')\"},
	{$c \"#dddfff\",$b \"#54487a\",$bor,$s,$sw \"7\",$ac,$mw 210,$ft \" $KERNEL\"},
		]"
do sleep 0.2
done


#                                                          
