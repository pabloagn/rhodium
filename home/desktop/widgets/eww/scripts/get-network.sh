#!/usr/bin/env bash
# Network stats with proper formatting

# Get active interface
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)

if [ -z "$INTERFACE" ]; then
    echo '{"icon":"≏ ⌽","download_speed":"0B","upload_speed":"0B","status":"disconnected"}'
    exit
fi

# Get speeds (bytes)
RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
sleep 1
RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

# Calculate speeds
RX_SPEED=$((($RX2 - $RX1)))
TX_SPEED=$((($TX2 - $TX1)))

# Format speeds
format_speed() {
    local bytes=$1
    if [ $bytes -lt 1024 ]; then
        echo "${bytes}B"
    elif [ $bytes -lt 1048576 ]; then
        echo "$((bytes / 1024))K"
    else
        echo "$((bytes / 1048576))M"
    fi
}

DOWN=$(format_speed $RX_SPEED)
UP=$(format_speed $TX_SPEED)

# Check if WiFi or Ethernet
if iwconfig $INTERFACE 2>/dev/null | grep -q "ESSID"; then
    ICON="≏"
else
    ICON="≏"
fi

echo "{\"icon\":\"$ICON\",\"download_speed\":\"$DOWN\",\"upload_speed\":\"$UP\",\"status\":\"connected\"}"
