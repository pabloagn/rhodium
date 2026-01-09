#!/usr/bin/env bash
#
# WiFi Interface Switcher for NETGEAR A8000 USB Adapter
# Automatically switches between internal WiFi and external USB adapter
#
# Internal adapter: wlp98s0 (PCIe, Intel)
# External adapter: wlp101s0f0u1 (USB, NETGEAR A8000 / mt7921u)
#

set -euo pipefail

# Configuration
INTERNAL_IFACE="wlp98s0"
EXTERNAL_IFACE="wlp101s0f0u1"
LOG_TAG="rh-wifi-switch"

log() {
    logger -t "$LOG_TAG" "$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Check if an interface exists
iface_exists() {
    [[ -d "/sys/class/net/$1" ]]
}

# Check if an interface is connected (has an active connection)
iface_connected() {
    local state
    state=$(nmcli -t -f STATE device show "$1" 2>/dev/null | cut -d: -f2 || echo "unknown")
    [[ "$state" == "100 (connected)" ]] || [[ "$state" == "connected" ]]
}

# Get current WiFi SSID for an interface
get_ssid() {
    nmcli -t -f GENERAL.CONNECTION device show "$1" 2>/dev/null | cut -d: -f2 || echo ""
}

# Connect an interface to a specific SSID
connect_to_ssid() {
    local iface="$1"
    local ssid="$2"

    if [[ -z "$ssid" ]] || [[ "$ssid" == "--" ]]; then
        log "No SSID to connect to, attempting to autoconnect on $iface"
        nmcli device connect "$iface" 2>/dev/null || true
    else
        log "Connecting $iface to SSID: $ssid"
        nmcli device wifi connect "$ssid" ifname "$iface" 2>/dev/null || \
            nmcli device connect "$iface" 2>/dev/null || true
    fi
}

# Disconnect an interface
disconnect_iface() {
    local iface="$1"
    log "Disconnecting interface: $iface"
    nmcli device disconnect "$iface" 2>/dev/null || true
}

# Main switching logic
main() {
    log "WiFi switch triggered"

    # Small delay to let the USB device fully initialize
    sleep 2

    if iface_exists "$EXTERNAL_IFACE"; then
        # External adapter is present - switch to it
        log "External adapter ($EXTERNAL_IFACE) detected"

        # Get current SSID from internal adapter if connected
        local current_ssid=""
        if iface_connected "$INTERNAL_IFACE"; then
            current_ssid=$(get_ssid "$INTERNAL_IFACE")
            log "Current SSID on internal adapter: $current_ssid"
        fi

        # Disconnect internal adapter
        disconnect_iface "$INTERNAL_IFACE"

        # Connect external adapter to the same network (or autoconnect)
        connect_to_ssid "$EXTERNAL_IFACE" "$current_ssid"

        # Wait for connection and verify
        sleep 3
        if iface_connected "$EXTERNAL_IFACE"; then
            log "Successfully switched to external adapter ($EXTERNAL_IFACE)"
        else
            log "Warning: External adapter may not be fully connected yet"
        fi
    else
        # External adapter is not present - switch back to internal
        log "External adapter not detected, reverting to internal adapter ($INTERNAL_IFACE)"

        # Connect internal adapter
        nmcli device connect "$INTERNAL_IFACE" 2>/dev/null || true

        # Wait for connection and verify
        sleep 3
        if iface_connected "$INTERNAL_IFACE"; then
            log "Successfully switched to internal adapter ($INTERNAL_IFACE)"
        else
            log "Warning: Internal adapter may not be fully connected yet"
        fi
    fi

    # Log final state
    log "Final state:"
    nmcli device status | grep -E "^wlp" | while read -r line; do
        log "  $line"
    done
}

main "$@"
