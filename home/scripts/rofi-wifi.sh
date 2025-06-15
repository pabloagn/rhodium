#!/usr/bin/env bash

set -euo pipefail

wifi_menu() {
    ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

    # Get WiFi interface
    WIFI_INTERFACE=$(nmcli device | grep wifi | head -1 | awk '{print $1}')
    [[ -z "$WIFI_INTERFACE" ]] && {
        notify-send "WiFi" "No WiFi interface found"
        return
    }

    # Check WiFi status
    wifi_status=$(nmcli radio wifi)

    local options=()

    if [[ "$wifi_status" == "enabled" ]]; then
        options+=("⊹ Turn Off WiFi <i>(Disable Radio)</i>")
        options+=("⊹ Rescan Networks <i>(Refresh List)</i>")

        # Get current connection
        current_ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
        [[ -n "$current_ssid" ]] && options+=("⊹ Disconnect from $current_ssid <i>(Current)</i>")

        # Get saved connections
        mapfile -t saved_connections < <(nmcli -t -f name,type connection show | grep ':802-11-wireless$' | cut -d: -f1)

        # Get available networks
        mapfile -t available_networks < <(nmcli -t -f ssid,signal,security dev wifi list | sort -t: -k2 -nr)

        # Show saved networks first
        for saved in "${saved_connections[@]}"; do
            if [[ -n "$saved" && "$saved" != "$current_ssid" ]]; then
                # Check if saved network is available
                if echo "${available_networks[@]}" | grep -q "^$saved:"; then
                    signal=$(echo "${available_networks[@]}" | grep "^$saved:" | head -1 | cut -d: -f2)
                    security=$(echo "${available_networks[@]}" | grep "^$saved:" | head -1 | cut -d: -f3)
                    sec_info="${security:+🔒}"
                    options+=("⊹ Connect to $saved <i>(Saved ${signal}% $sec_info)</i>")
                else
                    options+=("⊹ Connect to $saved <i>(Saved Network)</i>")
                fi
                options+=("⊹ Forget $saved <i>(Remove Saved)</i>")
            fi
        done

        # Show available networks
        declare -A seen_networks
        for network in "${available_networks[@]}"; do
            if [[ -n "$network" ]]; then
                ssid=$(echo "$network" | cut -d: -f1)
                signal=$(echo "$network" | cut -d: -f2)
                security=$(echo "$network" | cut -d: -f3)

                # Skip if already processed or current connection
                [[ -z "$ssid" || "${seen_networks[$ssid]:-}" == "1" || "$ssid" == "$current_ssid" ]] && continue
                seen_networks["$ssid"]=1

                # Skip if it's a saved connection (already shown above)
                [[ " ${saved_connections[*]} " =~ " $ssid " ]] && continue

                sec_info="${security:+🔒}"
                options+=("⊹ Connect to $ssid <i>(${signal}% $sec_info)</i>")
            fi
        done
    else
        options+=("⊹ Turn On WiFi <i>(Enable Radio)</i>")
    fi

    [[ ${#options[@]} -eq 0 ]] && options+=("⊹ No Networks Available <i>(Check Service)</i>")

    selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)
    [[ -z "$selected" ]] && return

    case "$selected" in
    *"Turn On WiFi"*)
        nmcli radio wifi on
        notify-send "WiFi" "Enabled"
        ;;
    *"Turn Off WiFi"*)
        nmcli radio wifi off
        notify-send "WiFi" "Disabled"
        ;;
    *"Rescan Networks"*)
        nmcli device wifi rescan
        notify-send "WiFi" "Rescanning networks..."
        sleep 3
        # Rerun menu to show updated list
        "$0"
        ;;
    *"Disconnect from "*)
        nmcli connection down "$current_ssid"
        notify-send "WiFi" "Disconnected from $current_ssid"
        ;;
    *"Connect to "*)
        ssid=$(echo "$selected" | sed 's/⊹ Connect to \(.*\) <i>.*/\1/')

        # Check if it's a saved connection
        if nmcli -t -f name connection show | grep -q "^$ssid$"; then
            nmcli connection up "$ssid"
            notify-send "WiFi" "Connecting to $ssid"
        else
            # New network - check if it needs password
            if nmcli -t -f ssid,security dev wifi list | grep "^$ssid:" | grep -q ":.*--security"; then
                # Network has security
                password=$(rofi -dmenu -password -P "Password for $ssid: " -theme "$ROFI_THEME")
                [[ -z "$password" ]] && return
                nmcli device wifi connect "$ssid" password "$password"
            else
                # Open network
                nmcli device wifi connect "$ssid"
            fi
            notify-send "WiFi" "Connecting to $ssid"
        fi
        ;;
    *"Forget "*)
        ssid=$(echo "$selected" | sed 's/⊹ Forget \(.*\) <i>.*/\1/')
        nmcli connection delete "$ssid"
        notify-send "WiFi" "Forgot network $ssid"
        ;;
    esac
}

wifi_menu
