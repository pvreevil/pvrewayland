#!/bin/sh

newsboat

newsboat -x print-unread | awk '{print $1}' >$HOME/.config/sway/conf/newsboat/unread
