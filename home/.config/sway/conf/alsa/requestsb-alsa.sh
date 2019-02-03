#!/bin/sh

getvol () {

VOL=$(amixer -M | head -5 | awk -F"[][]" '/dB/ { printf "%0.0f\n", $2 }')
STATUS=$(amixer sget Master | awk -F"[][]" '/dB/ { print $6 }')

if [ "$STATUS" = "off" ]; then
	VOLI=""
elif [ "$VOL" = "0" ]; then
	VOLI=""
elif [ "$VOL" -gt "59"  ]; then
		VOLI=""
elif [ "$VOL" -lt "20"  ]; then
		VOLI=""
	else
		VOLI=""
fi
}
#         

