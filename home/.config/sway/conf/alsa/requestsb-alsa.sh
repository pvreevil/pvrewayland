#!/bin/sh

VOL=$(amixer sget Master | awk -F"[][]" '/dB/ { printf "%0.0f\n", $2 }')
STATUS=$(amixer sget Master | awk -F"[][]" '/dB/ { print $6 }')

if [ "$STATUS" = "off" ]; then
	echo " "
elif [ "$VOL" = "0" ]; then
	echo " "
elif [ "$VOL" -gt "59"  ]; then
		echo " $VOL"
elif [ "$VOL" -lt "20"  ]; then
		echo "$VOL"
	else
		echo "$VOL"
fi

#         

