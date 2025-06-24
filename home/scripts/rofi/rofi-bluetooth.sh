#!/usr/bin/env bash
# TODO: Do this right

set -euo pipefail

bluetooth_menu() {
    ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

    # Check if bluetooth is powered on
    bt_power_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

    local options=()

    # Power management options
    if [[ "$bt_power_status" == "yes" ]]; then
        options+=("⊹ Turn Off Bluetooth <i>(Disable Radio)</i>")
        options+=("⊹ Scan for Devices <i>(Discover New)</i>")
        options+=("⊹ Make Discoverable <i>(Pairable Mode)</i>")

        # Get paired devices
        mapfile -t paired_devices < <(bluetoothctl paired-devices | sed 's/Device //')

        for device in "${paired_devices[@]}"; do
            if [[ -n "$device" ]]; then
                mac=$(echo "$device" | awk '{print $1}')
                name=$(echo "$device" | cut -d' ' -f2-)

                # Check connection status
                if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                    options+=("⊹ Disconnect $name <i>(Connected)</i>")
                else
                    options+=("⊹ Connect $name <i>(Paired)</i>")
                fi
                options+=("⊹ Unpair $name <i>(Remove Device)</i>")
            fi
        done

        # Get discoverable devices (if scanning)
        if bluetoothctl discoverable-timeout | grep -q "0x00000000"; then
            mapfile -t available_devices < <(bluetoothctl devices | grep -v "$(bluetoothctl paired-devices)" | sed 's/Device //' || true)

            for device in "${available_devices[@]}"; do
                if [[ -n "$device" ]]; then
                    mac=$(echo "$device" | awk '{print $1}')
                    name=$(echo "$device" | cut -d' ' -f2-)
                    options+=("⊹ Pair $name <i>(Available)</i>")
                fi
            done
        fi
    else
        options+=("⊹ Turn On Bluetooth <i>(Enable Radio)</i>")
    fi

    [[ ${#options[@]} -eq 0 ]] && options+=("⊹ No Options Available <i>(Check Service)</i>")

    selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)
    [[ -z "$selected" ]] && return

    case "$selected" in
    *"Turn On Bluetooth"*)
        bluetoothctl power on
        notify-send "Bluetooth" "Enabled"
        ;;
    *"Turn Off Bluetooth"*)
        bluetoothctl power off
        notify-send "Bluetooth" "Disabled"
        ;;
    *"Scan for Devices"*)
        bluetoothctl scan on &
        sleep 5
        bluetoothctl scan off
        notify-send "Bluetooth" "Scan completed"
        # Rerun menu to show new devices
        "$0"
        ;;
    *"Make Discoverable"*)
        bluetoothctl discoverable on
        notify-send "Bluetooth" "Now discoverable for 5 minutes"
        sleep 300
        bluetoothctl discoverable off
        ;;
    *"Connect "*)
        device_name=$(echo "$selected" | sed 's/⊹ Connect \(.*\) <i>.*/\1/')
        mac=$(bluetoothctl paired-devices | grep "$device_name" | awk '{print $2}')
        bluetoothctl connect "$mac"
        notify-send "Bluetooth" "Connecting to $device_name"
        ;;
    *"Disconnect "*)
        device_name=$(echo "$selected" | sed 's/⊹ Disconnect \(.*\) <i>.*/\1/')
        mac=$(bluetoothctl paired-devices | grep "$device_name" | awk '{print $2}')
        bluetoothctl disconnect "$mac"
        notify-send "Bluetooth" "Disconnected from $device_name"
        ;;
    *"Pair "*)
        device_name=$(echo "$selected" | sed 's/⊹ Pair \(.*\) <i>.*/\1/')
        mac=$(bluetoothctl devices | grep "$device_name" | awk '{print $2}')
        bluetoothctl pair "$mac"
        notify-send "Bluetooth" "Pairing with $device_name"
        ;;
    *"Unpair "*)
        device_name=$(echo "$selected" | sed 's/⊹ Unpair \(.*\) <i>.*/\1/')
        mac=$(bluetoothctl paired-devices | grep "$device_name" | awk '{print $2}')
        bluetoothctl remove "$mac"
        notify-send "Bluetooth" "Removed $device_name"
        ;;
    esac
}

bluetooth_menu
