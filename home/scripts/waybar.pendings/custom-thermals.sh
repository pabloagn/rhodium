#!/usr/bin/env bash

set -euo pipefail

# --- Raw Sensor Grabs ---
get_cpu_temp() { sensors -j | jq -r 'first(.[]|select(has("Tctl"))|.Tctl.temp1_input)'; }
get_amd_gpu_temp() { sensors -j | jq -r 'first(.[]|select(has("edge"))|.edge.temp1_input)'; }
get_amd_gpu_power() { sensors -j | jq -r 'first(.[]|select(.PPT.power1_input)|.PPT.power1_input)'; }
get_nvidia_gpu_temp() { sensors -j | jq -r 'first(.[]|select(has("Composite"))|.Composite.temp1_input)'; }
get_nvme_temp() { sensors -j | jq -r 'first(.[]|select((.Adapter//"")=="PCI adapter" and .temp1.temp1_input and (.temp1.temp1_input<100))|.temp1.temp1_input)'; }
get_ambient_temp() { sensors -j | jq -r 'first(.[]|select(.Adapter=="ACPI interface" and .temp1.temp1_input)|.temp1.temp1_input)'; }
get_bat_v() { sensors -j | jq -r 'first(.[]|select(.Adapter=="ACPI interface" and .in0.in0_input)|.in0.in0_input)'; }
get_bat_i() { sensors -j | jq -r 'first(.[]|select(.Adapter=="ACPI interface" and .curr1.curr1_input)|.curr1.curr1_input)'; }
get_fan_rpm() { sensors -j | jq -r 'first(.[]|select(.cpu_fan.fan1_input)|.cpu_fan.fan1_input)'; }

# --- Tiny Format Helpers ---
round() {
    printf '%.0f' "$1"
}

as_c() { printf '%s°C' "$(round "$1")"; }

metric_json() {
    jq -nc --arg t "$1" '{text:$t, class:"bar_item"}'
}


# --- Output Selectors ---
case "${1:-}" in
cpu)
    metric_json "$(as_c $(get_cpu_temp))"
    ;;
amd)
    metric_json "$(as_c $(get_amd_gpu_temp))"
    ;;
nvidia)
    metric_json "$(as_c $(get_nvidia_gpu_temp))"
    ;;
gpupower)
    metric_json "$(round $(get_amd_gpu_power))W"
    ;;
nvme)
    metric_json "$(as_c $(get_nvme_temp))"
    ;;
amb)
    metric_json "$(as_c $(get_ambient_temp))"
    ;;
batv)
    metric_json "$(get_bat_v)V"
    ;;
bati)
    metric_json "$(get_bat_i)A"
    ;;
fan)
    metric_json "$(round $(get_fan_rpm))RPM"
    ;;
full)
    jq -nc --arg cpu "$(as_c $(get_cpu_temp))" \
        --arg agpu "$(as_c $(get_amd_gpu_temp))" \
        --arg ngpu "$(as_c $(get_nvidia_gpu_temp))" \
        --arg pwr "$(round $(get_amd_gpu_power))W" \
        --arg nvme "$(as_c $(get_nvme_temp))" \
        --arg amb "$(as_c $(get_ambient_temp))" \
        --arg bv "$(get_bat_v)V" \
        --arg bi "$(get_bat_i)A" \
        --arg fan "$(round $(get_fan_rpm))RPM" \
        '{text:($cpu+"  AMD "+$agpu+"  NV "+$ngpu+"  GPU "+$pwr+"  NVMe "+$nvme+"  Amb "+$amb+"  Bat "+$bv+" "+$bi+"  Fan "+$fan)}'
    ;;
*) # summary (CPU only) with percentage for icon colouring
    cpu=$(get_cpu_temp)
    jq -nc --arg cpu "$cpu" '{text:((($cpu|tonumber)|round|tostring)+"°C"), percentage:(($cpu|tonumber)|round), class:"bar_item"}'
    ;;
esac
