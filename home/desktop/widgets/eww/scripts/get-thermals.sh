#!/usr/bin/env bash
set -euo pipefail

SEP=" · "

out=$(sensors)

cpu=$(awk '/Tctl:|Tdie:|Package id 0:/{
             gsub("[+°C]","",$2); gsub("[+°C]","",$4);
             print ($2?$2:$4); exit}' <<<"$out")

gpu=$(awk '/^amdgpu/{f=1;next} f&&/edge:/{gsub("[+°C]","",$2);print $2;exit}' <<<"$out")
ssd=$(awk '/^nvme/{f=1;next} f&&/Composite:/{gsub("[+°C]","",$2);print $2;exit}' <<<"$out")
wifi=$(awk '/^mt7921/{f=1;next} f&&/temp1:/{gsub("[+°C]","",$2);print $2;exit}' <<<"$out")
fan=$(awk '/cpu_fan:/{gsub("[^0-9]","",$2);print $2;exit}' <<<"$out")

details=""
[ -n "$gpu" ] && details+="${SEP}[G] ${gpu}°C"
[ -n "$ssd" ] && details+="${SEP}[S] ${ssd}°C"
[ -n "$wifi" ] && details+="${SEP}[W] ${wifi}°C"
[ -n "$fan" ] && details+="${SEP}[F] ${fan} RPM"

printf '{"cpu":%.1f,"details":"%s"}\n' "${cpu:-0}" "$details"
