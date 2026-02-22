#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "osmium"

# --- Menu Options (Alphabetically Sorted) ---
options=(
  "Authelia:open_authelia"
  "Backups:open_backups"
  "Calibre-Web:open_calibre"
  "Cloudflare Dashboard:open_cloudflare_dashboard"
  "Cloudflare DNS:open_cloudflare_dns"
  "Drone CI:open_drone"
  "Grafana:open_grafana"
  "Homepage:open_homepage"
  "Image Registry:open_registry"
  "Immich:open_immich"
  "Langfuse:open_langfuse"
  "LLMs:open_llms"
  "Namecheap:open_namecheap"
  "Navidrome:open_navidrome"
  "Nextcloud:open_nextcloud"
  "PasteBin:open_pastebin"
  "Plex:open_plex"
  "Prowlarr:open_prowlarr"
  "qBittorrent:open_qbittorrent"
  "Radarr:open_radarr"
  "Sonarr:open_sonarr"
  "Tailscale:open_tailscale"
  "Temporal Workflows:open_temporal"
  "Traefik:open_traefik"
  "Vaultwarden:open_vaultwarden"
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
  open_url "https://auth.rhodium.sh/" "Authelia"
}

open_backups() {
  open_url "https://backups.rhodium.sh/" "Backups"
}

open_calibre() {
  open_url "https://books.rhodium.sh/" "Calibre-Web"
}

open_cloudflare_dashboard() {
  open_url "https://dash.cloudflare.com/" "Cloudflare Dashboard"
}

open_cloudflare_dns() {
  open_url "https://dns.rhodium.sh/install.html" "Cloudflare DNS"
}

open_drone() {
  open_url "https://drone.rhodium.sh/" "Drone CI"
}

open_grafana() {
  open_url "https://grafana.rhodium.sh/?orgId=1&from=now-6h&to=now&timezone=browser&refresh=30s" "Grafana"
}

open_homepage() {
  open_url "https://dashboard.rhodium.sh/" "Homepage"
}

open_registry() {
  open_url "https://registry.rhodium.sh/" "Image Registry"
}

open_immich() {
  open_url "https://pictures.rhodium.sh/" "Immich"
}

open_langfuse() {
  open_url "http://192.168.1.117:3000/project/proj-agent-fleet" "Langfuse"
}

open_llms() {
  open_url "https://llm.rhodium.sh/" "LLMs"
}

open_namecheap() {
  open_url "https://www.namecheap.com/myaccount/login/?ReturnUrl=%2fDomains%2fDomainControlPanel%2frhodium.sh%2fdomain%2f" "Namecheap"
}

open_navidrome() {
  open_url "https://music.rhodium.sh/" "Navidrome"
}

open_nextcloud() {
  open_url "https://cloud.rhodium.sh/" "Nextcloud"
}

open_pastebin() {
  open_url "https://paste.rhodium.sh/" "PasteBin"
}

open_plex() {
  open_url "http://192.168.178.141:32400/web/index.html#!/" "Plex"
}

open_prowlarr() {
  open_url "https://indexers.rhodium.sh/" "Prowlarr"
}

open_qbittorrent() {
  open_url "https://downloads.rhodium.sh/" "qBittorrent"
}

open_radarr() {
  open_url "https://films.rhodium.sh/" "Radarr"
}

open_sonarr() {
  open_url "https://shows.rhodium.sh/" "Sonarr"
}

open_tailscale() {
  open_url "https://login.tailscale.com/admin/machines" "Tailscale"
}

open_temporal() {
  open_url "http://192.168.1.117:8088/namespaces/default/workflows" "Temporal Workflows"
}

open_traefik() {
  open_url "https://traefik.rhodium.sh/dashboard/#/" "Traefik"
}

open_vaultwarden() {
  open_url "https://vault.rhodium.sh/" "Vaultwarden"
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
