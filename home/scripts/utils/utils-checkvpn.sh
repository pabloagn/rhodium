#!/usr/bin/env bash

if nmcli connection show --active | grep -qi vpn; then
    echo '{"text": "[VPN ON]", "tooltip": "VPN Connection Active", "class": "vpn-on"}'
else
    echo '{"text": "[VPN ON]", "tooltip": "VPN Disconnected", "class": "vpn-off"}'
fi
