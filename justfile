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

# --- Default Recipe Shows Available Commands ---
default:
    @just --list --unsorted

# --- Recipes ---

# Fast rebuild and switch with minimal output
fast host:
    @{{recipes_path}}/rh-switch.sh "{{host}}" "fast"

# Build and switch NixOS configuration
switch host:
    @{{recipes_path}}/rh-switch.sh "{{host}}"

# Build without switching [test build]
build host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "build"

# Rebuild and boot into new generation
boot host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "boot"

# Dry run - show what would be built
dry host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "dry"

# Development rebuild with verbose output
dev host:
    @{{recipes_path}}/rh-build.sh "{{host}}" "dev"

# Update all flake inputs
update:
    @{{recipes_path}}/rh-update.sh

# Update specific flake input
update-input input:
    @{{recipes_path}}/rh-update.sh "{{input}}"

# Update nixpkgs-unstable input
update-unstable:
    @nix flake lock --update-input nixpkgs-unstable

# Show flake metadata
flake-info:
    @{{recipes_path}}/rh-flake-info.sh

# Clean all garbage
gc:
    @{{recipes_path}}/rh-gc.sh all

# Remove old generations keeping N most recent [default: 5]
gc-keep generations="5":
    @{{recipes_path}}/rh-gc.sh keep "{{generations}}"

# Traditional time-based garbage collection
gc-days days="7":
    @{{recipes_path}}/rh-gc.sh days "{{days}}"

# Show system health status
health:
    @{{recipes_path}}/rh-health.sh

# List current generation details
generation:
    @{{recipes_path}}/rh-generation.sh

# Check for backup files in config
check-backups:
    @{{recipes_path}}/rh-check-backups.sh

# Find orphaned configuration files
orphans:
    @{{recipes_path}}/rh-orphans.sh

# Check for untracked files in repository
untracked:
    @{{recipes_path}}/rh-untracked.sh

# Remove orphaned configuration directories [interactive]
clean-orphans:
    @{{recipes_path}}/rh-clean-orphans.sh

# Clean all backup files
clean-backups:
    @{{recipes_path}}/rh-clean-backups.sh

# Update application caches
update-caches:
    @{{recipes_path}}/rh-update-caches.sh

# Rollback to previous generation
rollback:
    @{{recipes_path}}/rh-rollback.sh

# Format all nix files
fmt:
    @{{recipes_path}}/rh-fmt.sh

# Reload user services
reload-services:
    @{{recipes_path}}/rh-reload-services.sh

# Source user environment variables
source-user-vars:
    @{{recipes_path}}/rh-source-vars.sh
