#!/bin/sh

echo $(df -H /dev/sda2 | grep dev | awk '{print $4}')

