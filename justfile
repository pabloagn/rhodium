# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ▲ RHODIUM SYSTEM MANAGEMENT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# --- Configuration ---
set shell := ["bash", "-euo", "pipefail", "-c"]
set positional-arguments := true

# --- Internal Variables ---
flake_path := "."
build_path := flake_path + "/build"
recipes_path := build_path + "/recipes"

# --- Base ---
# Show Available Commands
default:
  @just --list --unsorted

# --- Build / Deploy / Switch ---
# Fast rebuild and switch (minimal output)
switch-fast host:
    @{{recipes_path}}/rh-switch.sh "{{host}}" "fast"

# Rebuild and switch current system
switch host:
    @{{recipes_path}}/rh-switch.sh "{{host}}"

# Rebuild only (no switch)
build host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "build"

# Rebuild and prepare for boot
boot host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "boot"

# Dry-run build
build-dry host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "dry"

# Development build (verbose)
build-dev host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "dev"

# Build for remote host
build-remote host target:
    @nix build .#nixosConfigurations.{{host}}.config.system.build.toplevel --builders "ssh://{{target}}"

# Deploy to remote host
deploy-remote host target:
    @nixos-rebuild switch --flake .#{{host}} --target-host {{target}} --use-remote-sudo

# --- Development & Testing ---
# Check flake syntax and evaluate
check:
    @nix flake check --all-systems

# Show what would be built without building
show-derivation host:
    @nix show-derivation .#nixosConfigurations.{{host}}.config.system.build.toplevel

# Compare two generations
diff-generations gen1 gen2:
    @nix profile diff-closures --profile /nix/var/nix/profiles/system {{gen1}} {{gen2}}

# Show flake dependency tree
show-deps:
    @nix flake show --all-systems

# Profile build time
profile-build host:
    @{{recipes_path}}/rh-profile-build.sh "{{host}}"

# --- Flake & Input Management ---
# Update all flake inputs
update:
    @{{recipes_path}}/rh-update.sh

# Update a specific flake input
update-input input:
    @{{recipes_path}}/rh-update.sh "{{input}}"

# Update stable nixpkgs
update-stable:
    @nix flake lock --update-input nixpkgs

# Update unstable nixpkgs
update-unstable:
    @nix flake lock --update-input nixpkgs-unstable

# Show flake metadata
flake-info:
    @{{recipes_path}}/rh-flake-info.sh

# --- Garbage Collection ---
# Collect all garbage
gc:
    @{{recipes_path}}/rh-gc.sh all

# Keep last N generations
gc-keep generations="5":
    @{{recipes_path}}/rh-gc.sh keep "{{generations}}"

# Remove generations older than N days
gc-days days="7":
    @{{recipes_path}}/rh-gc.sh days "{{days}}"

# --- System Maintenance ---
# Roll back to previous generation
rollback:
    @{{recipes_path}}/rh-rollback.sh

# List current generation details
generation:
    @{{recipes_path}}/rh-generation.sh

# Check system health
health:
    @{{recipes_path}}/rh-health.sh

# Repair store
repair-store:
  sudo nix-store --verify --check-contents --repair

# Reload user systemd services
reload-services:
    @{{recipes_path}}/rh-reload-services.sh

# Source user environment variables
source-user-vars:
    @{{recipes_path}}/rh-source-vars.sh

# Update application caches
update-caches:
    @{{recipes_path}}/rh-update-caches.sh

# Format all .nix files
fmt:
    @{{recipes_path}}/rh-fmt.sh

# --- Performance & Analysis ---
# Show store size by path
store-size:
    @{{recipes_path}}/rh-store-size.sh

# Find largest store paths
largest-paths:
    @{{recipes_path}}/rh-largest-paths.sh

# --- Backup & Recovery ---
# Export system configuration
export-config host output="./system-backup.json":
    @nix eval --json .#nixosConfigurations.{{host}}.config > {{output}}

# Create hardware config backup
backup-hardware:
    @nixos-generate-config --show-hardware-config > hardware-backup.nix

# --- File Hygiene & Diagnostics ---
# Find config backup files
find-backups:
    @{{recipes_path}}/rh-check-backups.sh

# Find orphaned config dirs
find-orphans:
    @{{recipes_path}}/rh-orphans.sh

# Find untracked files
find-untracked:
    @{{recipes_path}}/rh-untracked.sh

# Remove orphaned config dirs (interactive)
clean-orphans:
    @{{recipes_path}}/rh-clean-orphans.sh

# Remove all backup files
clean-backups:
    @{{recipes_path}}/rh-clean-backups.sh

# --- Help ---
# Open Rhodium Docs on Browser
docs:
  @xdg-open "https://rhodium.solenoidlabs.com/docs" > /dev/null 2>&1 &
