#!/bin/sh

NUMBER=$(newsboat -x print-unread | awk '{print $1}')

printf $NUMBER>$BARPATH/newsboat/unread
