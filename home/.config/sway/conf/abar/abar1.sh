#!/bin/sh

pkill requestsb-

export BARPATH=~/.config/sway/conf/

KERNEL=$(uname -r)
$BARPATH/netspeed/requestsb-netspeed.sh &
$BARPATH/github/requestsb-github.sh  &
$BARPATH/newsboat/requestsb-newsboat.sh      &
$BARPATH/reddit/requestsb-reddit.sh  &

#JSON
source $BARPATH/abar/colors.sh 
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
	CPU=$(tail -1 /tmp/ghud/cpu  | awk -F. '{print $1}')
	GPU=$(tail -1 /tmp/ghud/GPU_load)
	GH=$(cat $BARPATH/github/unread)
	RDD=$(cat $BARPATH/reddit/unread)
	RSS=$(cat $BARPATH/newsboat/unread)
}
while
	getvar
	getcolor
	printf %s	",[
	{$c \"$gc\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color7\",$b \"$gc\",$s,$sw \"0\",$ac,$mw 80,$ft \" $GPU%\"},
	{$c \"$gc\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$mc\",$s,$sw \"0\",$ac,$ft \"\"},
        {$c \"$color7\",$b \"$mc\",$s,$sw \"0\",$ac,$mw 80,$ft \" $MEM%\"},
	{$c \"$mc\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$cc\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color7\",$b \"$cc\",$s,$sw \"0\",$ac,$mw 80,$ft \" $CPU%\"},
	{$c \"$cc\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color4\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color7\",$b \"$color4\",$s,$sw\"0\",$ac,$mw 210,$ft \" $NET \"},
	{$c \"$color4\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color3\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color7\",$b \"$color3\",$s,$sw \"0\",$ac,$mw 80,$ft \"$($BARPATH/alsa/requestsb-alsa.sh)\"},
	{$c \"$color3\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#333333\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#fafafa\",$b \"#333333\",$s,$sw \"0\",$ac,$mw 80,$ft \" $GH\"},
	{$c \"#333333\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#ff4500\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#cee3f8\",$b \"#ff4500\",$s,$sw \"0\",$ac,$mw 80,$ft \" $RDD\"},
	{$c \"#ff4500\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#f26522\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#ffffff\",$b \"#f26522\",$s,$sw \"0\",$ac,$mw 80,$ft \" $RSS\"},
	{$c \"#f26522\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color0\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color7\",$b \"$color0\",$s,$sw \"0\",$ac,$mw 210,$ft \"$(date +'  %A, %d-%H:%M')\"},
	{$c \"$color0\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color8\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"$color7\",$b \"$color8\",$s,$sw \"0\",$ac,$mw 210,$ft \" $(uptime --pretty | sed 's/up //' | sed 's/\ years\?,/y/' | sed 's/\ days\?,/d/' | sed 's/\ hours\?,\?/h/' | sed 's/\ minutes\?/m/')\"},
	{$c \"$color8\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#54487a\",$s,$sw \"0\",$ac,$ft \"\"},
	{$c \"#dddfff\",$b \"#54487a\",$s,$sw \"0\",$ac,$mw 210,$ft \" $KERNEL\"},
	{$c \"#54487a\",$s,$sw \"0\",$ac,$ft \"\"},
		]"
do sleep 0.2
done


#                                                          
