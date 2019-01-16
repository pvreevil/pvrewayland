#!/bin/sh

VOL=$(amixer sget Master | awk -F"[][]" '/dB/ { printf "%0.0f\n", $2 }')
STATUS=$(amixer sget Master | awk -F"[][]" '/dB/ { print $6 }')

if [ "$STATUS" = "off" ]; then
	printf ""
elif [ "$VOL" = "0" ]; then
	printf ""
elif [ "$VOL" -gt "59"  ]; then
		printf " $VOL"
elif [ "$VOL" -lt "20"  ]; then
		printf "$VOL"
	else
		printf "$VOL"
fi

#         

