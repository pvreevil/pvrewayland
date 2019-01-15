#!/bin/sh

getcolor()      {

if [ "$GPU" -lt "40" ]; then
                gc=$colorl
        elif [ "$GPU" -lt "70" ]; then
                gc=$colorm
        else
                gc=$colorh
fi

if [ "$MEM" -lt "40" ]; then
                mc=$colorl
        elif [ "$MEM" -lt "70" ]; then
                mc=$colorm
        else
                mc=$colorh
fi

if [ "$CPU" -lt "40" ]; then
                cc=$colorl
        elif [ "$CPU" -lt "70" ]; then
                cc=$colorm
        else
                cc=$colorh
fi
}
