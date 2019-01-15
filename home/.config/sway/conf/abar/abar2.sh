#!/bin/sh

export BARPATH=~/.config/sway/conf/

KERNEL=$(uname -r)

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
	LOAD=$(cat /proc/loadavg | awk '{print $1" "$2" "$3}')
	MEM=$(free | grep Mem | awk '{print ($3+$6)/$2 * 100}' | awk -F. '{printf "%0.0f\n",$1"."substr($2,1,2)}')
	CPU=$(tail -1 /tmp/ghud/cpu  | awk -F. '{print $1}')
	GPU=$(tail -1 /tmp/ghud/GPU_load)
	GPUT=$(tail -1 /tmp/ghud/temperature)
	FPS=$(tail -1 /tmp/ghud/fps | awk -F. '{print $1}')
}

while
	getvar
	getcolor
	echo	",[
	{$c \"$color7\",$b \"$gc\",$bor,$s,$sw \"0\",$ac,$mw 210,$ft \"FPS:$FPS GPU:$GPU% $GPUT°\"},
	{$c \"$color7\",$b \"$mc\",$bor,$s,$sw \"0\",$ac,$mw 80,$ft \"$MEM%\"},
	{$c \"$color7\",$b \"$cc\",$bor,$s,$sw \"0\",$ac,$mw 80,$ft \" $CPU%\"},
	{$c \"$color7\",$b \"$color12\",$bor,$s,$sw \"0\",$ac,$mw 210,$ft \" $LOAD\"},
	{$c \"#dddfff\",$b \"#54487a\",$bor,$s,$sw \"0\",$ac,$mw 210,$ft \" $KERNEL\"},
		]"
do sleep 0.2
done

#                                                          
