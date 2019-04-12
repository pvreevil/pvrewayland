#!/usr/bin/env sh

public_ip="$(curl -s ident.me)"
distro="$(sed -rn '/^NAME/ s/^NAME="?([a-z A-Z]+).?$/\1/p' /etc/os-release)"
kernel="$(uname -r)"
filesystem="$(df -Th | awk '/ \/$/ {print $2}')"
ethernet="$(awk -F'=' '/DRIVER=/ {print $2}' /sys/class/net/{enp*,eth*}/device/uevent 2>/dev/null)"
wifi="$(awk -F'=' '/DRIVER=/ {print $2}' /sys/class/net/{wlp*,wlan*}/device/uevent 2>/dev/null)"
m_board="$(cat /sys/devices/virtual/dmi/id/board_{vendor,name,version} | awk 'BEGIN {RS=""}{gsub(/\n/," ",$0); print $1,$2",",$3,$4}')"
bios="$(cat /sys/devices/virtual/dmi/id/bios_{vendor,version} | tr '\n' ' ')"
cpu="$(awk -F ': ' '/model name/ {printf $2; exit}' /proc/cpuinfo | tr -s ' ')"
mem_info="$(free -m | awk '/Mem/{print $3"MiB", $2"MiB"}' OFS=' / ')"
disk_info="$(df -H | awk '/ \/$/ {print $3,"/",$2}')"
shell="$(basename $SHELL)"
gpu="$(lspci -v | grep VGA -A 1 | grep -ioP '(?<=Subsystem: ).*$')"

if [ -z ${ethernet} ];
then
	ethernet="Not found"
elif [ -z ${wifi} ];
then
	wifi="Not found"
fi

b=$(printf '%b' "\33[1m")
t=$(printf '%b' "\33[0m")

cat << EOF
${b}Distro:          ${t}${distro}
${b}Kernel:          ${t}${kernel}
${b}Motherboard:     ${t}${m_board}
${b}BIOS:            ${t}${bios}
${b}Processor:       ${t}${cpu}
${b}GPU:             ${t}${gpu}
${b}Filesystem:      ${t}${filesystem}
${b}Ethernet Driver: ${t}${ethernet}
${b}Wireless Driver: ${t}${wifi}
${b}Memory:          ${t}${mem_info}
${b}Disk:            ${t}${disk_info}
${b}Shell:           ${t}${shell}
${b}Public IP:       ${t}${public_ip}
EOF
