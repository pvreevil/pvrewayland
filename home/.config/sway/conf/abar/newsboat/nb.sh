#!/bin/sh

newsboat -x print-unread | awk '{print $1}' >$BARPATH/newsboat/unread
