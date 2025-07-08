#!/usr/bin/env bash
# Bluetooth status

if ! systemctl is-active --quiet bluetooth; then
    echo '{"icon":"","connected_count":0,"status_icon":"▼"}'
    exit
fi

POWERED=$(bluetoothctl show | grep "Powered: yes" && echo "true" || echo "false")
DEVICES=$(bluetoothctl devices Connected | wc -l)

if [ "$POWERED" = "false" ]; then
    STATUS_ICON="▽"
elif [ $DEVICES -gt 0 ]; then
    STATUS_ICON="▲"
else
    STATUS_ICON="△"
fi

echo "{\"icon\":\"\",\"connected_count\":$DEVICES,\"status_icon\":\"$STATUS_ICON\"}"
