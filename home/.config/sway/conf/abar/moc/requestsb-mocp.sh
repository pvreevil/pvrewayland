#!/bin/sh

mocstate(){
if [ "$(mocp -Q %state 2>&1 | grep .)" = "FATAL_ERROR: The server is not running!" ];then
	MOC="OFF"
elif [ "$(mocp -Q %state 2>&1 | grep .)" = "STOP" ];then
	MOC='STOP'
else 
#tr removing quotation marks to prevent issues with i3barjson
	MOC="$(mocp -Q %artist | tr -d '"') - $(mocp -Q %song |tr -d '"' )  $(mocp -Q %ct)/$(mocp -Q %tt)"
fi
}
