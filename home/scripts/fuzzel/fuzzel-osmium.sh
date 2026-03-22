#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "osmium"

# --- Menu Options (Alphabetically Sorted) ---
options=(
  "Authelia:open_authelia"
  "BookStack:open_bookstack"
  "Calibre-Web:open_calibre"
  "CloudBeaver:open_cloudbeaver"
  "Cloudflare Dashboard:open_cloudflare_dashboard"
  "Collabora:open_collabora"
  "File Browser:open_filebrowser"
  "Grafana:open_grafana"
  "Hoarder:open_hoarder"
  "Home Assistant:open_home_assistant"
  "Homepage:open_homepage"
  "Huntarr:open_huntarr"
  "Immich:open_immich"
  "Langfuse:open_langfuse"
  "Lidarr:open_lidarr"
  "MinIO:open_minio"
  "Namecheap:open_namecheap"
  "Navidrome:open_navidrome"
  "Nextcloud:open_nextcloud"
  "Plex:open_plex"
  "Portainer:open_portainer"
  "PrivateBin:open_privatebin"
  "Prowlarr:open_prowlarr"
  "qBittorrent:open_qbittorrent"
  "Radarr:open_radarr"
  "Seerr:open_seerr"
  "Sonarr:open_sonarr"
  "Tailscale:open_tailscale"
  "Temporal Workflows:open_temporal"
  "Traefik:open_traefik"
  "Uptime Kuma:open_uptime_kuma"
  "Whisparr:open_whisparr"
  "Exit:noop"
)

decorate_fuzzel_menu options

# --- Helper Function ---
open_url() {
  local url="$1"
  local name="$2"
  notify "$APP_TITLE" "Opening $name..."
  firefox -P "Personal" "$url" &
}

# --- URL Actions ---
open_authelia() {
  open_url "https://authelia.rhodium.sh/" "Authelia"
}

open_bookstack() {
  open_url "https://bookstack.rhodium.sh/" "BookStack"
}

open_calibre() {
  open_url "https://calibre.rhodium.sh/" "Calibre-Web"
}

open_cloudbeaver() {
  open_url "https://cloudbeaver.rhodium.sh/" "CloudBeaver"
}

open_cloudflare_dashboard() {
  open_url "https://dash.cloudflare.com/" "Cloudflare Dashboard"
}

open_collabora() {
  open_url "https://collabora.rhodium.sh/" "Collabora"
}

open_filebrowser() {
  open_url "https://filebrowser.rhodium.sh/" "File Browser"
}

open_grafana() {
  open_url "https://grafana.rhodium.sh/?orgId=1&from=now-6h&to=now&timezone=browser&refresh=30s" "Grafana"
}

open_hoarder() {
  open_url "https://hoarder.rhodium.sh/" "Hoarder"
}

open_home_assistant() {
  open_url "https://home-assistant.rhodium.sh/" "Home Assistant"
}

open_homepage() {
  open_url "https://homepage.rhodium.sh/" "Homepage"
}

open_huntarr() {
  open_url "https://huntarr.rhodium.sh/" "Huntarr"
}

open_immich() {
  open_url "https://immich.rhodium.sh/" "Immich"
}

open_langfuse() {
  open_url "http://192.168.178.141:3000/project/proj-agent-fleet" "Langfuse"
}

open_lidarr() {
  open_url "https://lidarr.rhodium.sh/" "Lidarr"
}

open_minio() {
  open_url "https://minio.rhodium.sh/" "MinIO"
}

open_namecheap() {
  open_url "https://www.namecheap.com/myaccount/login/?ReturnUrl=%2fDomains%2fDomainControlPanel%2frhodium.sh%2fdomain%2f" "Namecheap"
}

open_navidrome() {
  open_url "https://navidrome.rhodium.sh/" "Navidrome"
}

open_nextcloud() {
  open_url "https://nextcloud.rhodium.sh/" "Nextcloud"
}

open_plex() {
  open_url "http://192.168.178.141:32400/web/index.html#!/" "Plex"
}

open_portainer() {
  open_url "https://portainer.rhodium.sh/" "Portainer"
}

open_privatebin() {
  open_url "https://privatebin.rhodium.sh/" "PrivateBin"
}

open_prowlarr() {
  open_url "https://prowlarr.rhodium.sh/" "Prowlarr"
}

open_qbittorrent() {
  open_url "https://qbittorrent.rhodium.sh/" "qBittorrent"
}

open_radarr() {
  open_url "https://radarr.rhodium.sh/" "Radarr"
}

open_seerr() {
  open_url "https://seerr.rhodium.sh/" "Seerr"
}

open_sonarr() {
  open_url "https://sonarr.rhodium.sh/" "Sonarr"
}

open_tailscale() {
  open_url "https://login.tailscale.com/admin/machines" "Tailscale"
}

open_temporal() {
  open_url "http://192.168.178.141:8088/namespaces/default/workflows" "Temporal Workflows"
}

open_traefik() {
  open_url "https://traefik.rhodium.sh/dashboard/#/" "Traefik"
}

open_uptime_kuma() {
  open_url "https://uptime-kuma.rhodium.sh/" "Uptime Kuma"
}

open_whisparr() {
  open_url "https://whisparr.rhodium.sh/" "Whisparr"
}

noop() {
  :
}

# --- Main Logic ---
main() {
  local line_count
  line_count=$(get_fuzzel_line_count)

  local selected
  selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count")

  [[ -z "$selected" ]] && return

  if [[ -n "${menu_commands[$selected]:-}" ]]; then
    "${menu_commands[$selected]}"
  fi
}

main
