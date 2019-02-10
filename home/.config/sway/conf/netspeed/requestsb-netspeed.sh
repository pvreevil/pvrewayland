#!/bin/sh

# Auto detect interfaces
ifaces=$(ls /sys/class/net | grep -E '^(eth|wlan|enp|wlp)')
last_time=0
last_rx=0
last_tx=0
rate=""

readable() {
  local bytes=$1
  local kib=$(( bytes >> 10 ))
  if [ $kib -lt 0 ]; then
    printf "? K"
  elif [ $kib -gt 1024 ]; then
    local mib_int=$(( kib >> 10 ))
    local mib_dec=$(( kib % 1024 * 976 / 10000 ))
    if [ "$mib_dec" -lt 10 ]; then
      mib_dec="0${mib_dec}"
    fi
    printf "${mib_int}.${mib_dec} M"
  else
    printf "${kib} K"
  fi
}

update_rate() {
  local time=$(date +%s)
  local rx=0 tx=0 tmp_rx tmp_tx

  for iface in $ifaces; do
    read tmp_rx < "/sys/class/net/${iface}/statistics/rx_bytes"
    read tmp_tx < "/sys/class/net/${iface}/statistics/tx_bytes"
    rx=$(( rx + tmp_rx ))
    tx=$(( tx + tmp_tx ))
  done

  local interval=$(( $time - $last_time ))
  if [ $interval -gt 0 ]; then
	rate="$(readable $(( (rx - last_rx) / interval ))) $(readable $(( (tx - last_tx) / interval )))"
	upt="$(readable $(( (tx - last_tx) / interval )))"
	dwt="$(readable $(( (rx - last_rx) / interval )))"
  else
	rate=""
  fi

  last_time=$time
  last_rx=$rx
  last_tx=$tx
}

band()  {
        up=$(ip -br link | grep wlp | awk '{print $2}')
        update_rate

if [ "$up" = "DOWN" ]; then
         BW="x x x x"
elif [ "$up" = "" ]; then
         BW="x x x x"
else
         BW="${dwt} ${upt}"
fi

}

while
	band
	printf "$BW"> ~/.config/sway/conf/netspeed/speed
do sleep 1

done

