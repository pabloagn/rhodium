# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ▲ RHODIUM SYSTEM MANAGEMENT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Configuration
set shell := ["bash", "-euo", "pipefail", "-c"]
set positional-arguments := true

# Internal Variables
flake_path := "."
modules_path := flake_path + "/build"
assets_path := flake_path + "/assets"
version := "1.0.0"
repository := "https://github.com/pabloagn/rhodium"
author := "Rhodium"
timestamp := `date +%Y-%m-%d`

# Environment
user := env('USER')
home_dir := env('HOME')

# Unicode Symbols
sym_success := "▲"
sym_pending := "❖"
sym_partial := "◐"
sym_down := "▼"
sym_bullet := "▪"
sym_info := "✗"
bar_heavy := "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bar_light := "─────────────────────────────────────────────────────────────────────────────"

# Style
red := '\033[0;31m'
green := '\033[0;32m'
yellow := '\033[0;33m'
blue := '\033[0;34m'
magenta := '\033[0;35m'
cyan := '\033[0;36m'
reset := '\033[0m'

# Command definitions - one per line: "command|description"
help_data := '''
switch <host>|Build and switch NixOS configuration
build <host>|Build without switching [test build]
boot <host>|Rebuild and boot into new generation
fast <host>|Fast rebuild with minimal output
dev <host>|Development rebuild with verbose output
dry <host>|Dry run - show what would be built
rollback|Rollback to previous generation
update|Update all flake inputs
update-input <input>|Update specific flake input
update-caches|Update application caches
fmt|Format all nix files
gc-keep [N=5]|Remove old generations keeping N most recent
gc-days [N=7]|Collect generations older than N days
clean-orphans|Remove orphaned configuration directories
clean-backups|Clean all backup files
health|Show system health status
generation|List current generation details
flake-info|Show flake metadata
check-backups|Check for backup files in config
orphans|Find orphaned configuration files
untracked|Check for untracked files in repository
reload-services|Reload user services
'''

# Default recipe shows available commands
default:
    @printf "{{cyan}}{{bar_light}}{{reset}}\n"
    @cat "{{assets_path}}/calvin-m.txt"
    @printf "{{cyan}}{{bar_light}}{{reset}}\n"
    @printf "\n{{cyan}}Available Commands:{{reset}}\n"
    @echo '{{help_data}}' | grep -v '^$' | while IFS='|' read cmd desc; do \
        printf "  {{cyan}}{{sym_bullet}}{{reset}} {{green}}%-25s{{reset}} %s\n" "$cmd" "$desc"; \
    done
    @printf "\n"

# Build and switch NixOS configuration
switch host:
    @printf "{{yellow}}{{sym_pending}} Pre-flight checks for %s{{reset}}\n" "{{ host }}"
    @if nix flake check {{ flake_path }} 2>/dev/null; then \
    	printf "  {{green}}{{sym_success}} Flake validation passed{{reset}}\n"; \
    else \
    	printf "  {{yellow}}{{sym_partial}} Flake validation failed [continuing anyway]{{reset}}\n"; \
    fi
    @printf "{{yellow}}{{sym_pending}} Building and switching configuration...{{reset}}\n"
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }}
    @printf "{{yellow}}{{sym_pending}} Running post-build tasks...{{reset}}\n"
    @just source-user-vars
    @just update-caches
    @just reload-services
    @printf "{{green}}{{sym_success}} System rebuild complete{{reset}}\n"

source-user-vars:
    @printf "{{yellow}}{{sym_pending}} Sourcing User Vars{{reset}}\n"
    @if [ -f "/etc/profiles/per-user/{{user}}/etc/profile.d/hm-session-vars.sh" ]; then \
    	printf "  {{cyan}}{{sym_bullet}} Loading session variables{{reset}}\n"; \
    	source "/etc/profiles/per-user/{{user}}/etc/profile.d/hm-session-vars.sh"; \
    fi
    @printf "{{green}}{{sym_success}} Sourced User Vars{{reset}}\n"

reload-services:
    @printf "{{yellow}}{{sym_pending}} Reloading User Services{{reset}}\n"
    @systemctl --user daemon-reload
    @command -v niri >/dev/null 2>&1 && \
        niri msg action do-screen-transition --delay-ms 800 2>/dev/null || true
    @for service in rh-swaybg rh-waybar rh-mako; do \
        systemctl --user restart "$service.service" || true; \
    done
    @printf "{{green}}{{sym_success}} Reloaded User Services{{reset}}\n"

# Build without switching [test build]
build host:
    @printf "{{yellow}}{{sym_pending}} Building configuration for %s...{{reset}}\n" "{{ host }}"
    sudo nixos-rebuild build --flake {{ flake_path }}#{{ host }}
    @printf "{{green}}{{sym_success}} Build successful [not activated]{{reset}}\n"

# Rebuild and boot into new generation
boot host:
    @printf "{{yellow}}{{sym_pending}} Building boot configuration for %s...{{reset}}\n" "{{ host }}"
    sudo nixos-rebuild boot --flake {{ flake_path }}#{{ host }}
    @printf "{{green}}{{sym_success}} Will boot into new generation on next reboot{{reset}}\n"

# Dry run - show what would be built
dry host:
    @printf "{{yellow}}{{sym_pending}} Dry run for %s...{{reset}}\n" "{{ host }}"
    sudo nixos-rebuild dry-build --flake {{ flake_path }}#{{ host }}

# Fast rebuild with minimal output
fast host: && update-caches
    @printf "{{yellow}}{{sym_pending}} Fast switch for %s...{{reset}}\n" "{{ host }}"
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }} --fast

# Development rebuild with verbose output
dev host:
    @printf "{{yellow}}{{sym_partial}} Development build with trace output for %s{{reset}}\n" "{{ host }}"
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }} --show-trace -L

# Update all flake inputs
update:
    @printf "{{yellow}}{{sym_pending}} Updating all flake inputs...{{reset}}\n"
    nix flake update
    @printf "{{green}}{{sym_success}} Flake inputs updated{{reset}}\n"
    @printf "\n"
    @printf "{{cyan}}Input changes:{{reset}}\n"
    @git -C {{ flake_path }} diff flake.lock | grep -E "^\+" | grep -E "(lastModified|narHash)" | head -10 || true

# Update specific flake input
update-input input:
    @printf "{{yellow}}{{sym_pending}} Updating input: %s...{{reset}}\n" "{{ input }}"
    nix flake update {{ input }}
    @printf "{{green}}{{sym_success}} Updated input: %s{{reset}}\n" "{{ input }}"

# Show flake metadata
flake-info:
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "{{cyan}}{{sym_success}} FLAKE INFORMATION{{reset}}\n"
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "\n"
    nix flake metadata {{ flake_path }}

# Remove old generations keeping N most recent [default: 5]
gc-keep generations="5":
    @printf "{{yellow}}{{sym_pending}} Analyzing generations...{{reset}}\n"
    @current_gen=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print $1}'); \
    total_gens=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l); \
    printf "  Current generation: %s\n" "$current_gen"; \
    printf "  Total generations: %s\n" "$total_gens"; \
    printf "  Generations to keep: %s [plus current]\n" "{{ generations }}"; \
    printf "\n"; \
    gens_to_keep=$(({{ generations }} + 1)); \
    if [ $total_gens -le $gens_to_keep ]; then \
    	printf "{{yellow}}{{sym_partial}} Nothing to collect [already at or below target]{{reset}}\n"; \
    	exit 0; \
    fi; \
    printf "{{yellow}}{{sym_pending}} Collecting garbage...{{reset}}\n"; \
    keep_from=$((current_gen - {{ generations }})); \
    for gen in $(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | awk '{print $1}'); do \
    	if [ "$$gen" -lt "$$keep_from" ] && [ "$$gen" != "$$current_gen" ]; then \
    		printf "  Removing generation %s...\n" "$$gen"; \
    		sudo nix-env --delete-generations $$gen -p /nix/var/nix/profiles/system 2>/dev/null || true; \
    	fi; \
    done; \
    printf "\n"; \
    printf "{{yellow}}{{sym_pending}} Running garbage collector...{{reset}}\n"; \
    sudo nix-collect-garbage; \
    nix-collect-garbage; \
    new_total=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l); \
    printf "\n"; \
    printf "{{green}}{{sym_success}} Garbage collection complete{{reset}}\n"; \
    printf "  Remaining generations: %s\n" "$$new_total"

# Traditional time-based garbage collection
gc-days days="7":
    @printf "{{yellow}}{{sym_pending}} Collecting generations older than %s days...{{reset}}\n" "{{ days }}"
    sudo nix-collect-garbage --delete-older-than {{ days }}d
    nix-collect-garbage --delete-older-than {{ days }}d
    @printf "{{green}}{{sym_success}} Garbage collection complete{{reset}}\n"

# Show system health status
health:
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "{{cyan}}{{sym_success}} SYSTEM HEALTH{{reset}}\n"
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "\n"
    @printf "{{yellow}}{{sym_pending}} Flake Status{{reset}}\n"
    @if git -C {{ flake_path }} diff --quiet; then \
    	printf "  {{green}}{{sym_success}} No uncommitted changes{{reset}}\n"; \
    else \
    	printf "  {{yellow}}{{sym_partial}} Uncommitted changes present{{reset}}\n"; \
    fi
    @untracked=$(git -C {{ flake_path }} ls-files --others --exclude-standard | wc -l); \
    if [ "$$untracked" -eq 0 ]; then \
    	printf "  {{green}}{{sym_success}} No untracked files{{reset}}\n"; \
    else \
    	printf "  {{yellow}}{{sym_partial}} $$untracked untracked files{{reset}}\n"; \
    fi
    @printf "\n"
    @printf "{{yellow}}{{sym_pending}} Disk Usage{{reset}}\n"
    @store_size=$(du -sh /nix/store 2>/dev/null | cut -f1); \
    printf "  Nix store: %s\n" "$$store_size"
    @root_usage=$(df -h / | tail -1 | awk '{print $5}'); \
    printf "  Root partition: %s used\n" "$$root_usage"
    @printf "\n"
    @printf "{{yellow}}{{sym_pending}} Generations{{reset}}\n"
    @current_gen=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print $1}'); \
    total_gens=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l); \
    printf "  Current: %s\n" "$$current_gen"; \
    printf "  Total: %s\n" "$$total_gens"
    @printf "\n"
    @printf "{{yellow}}{{sym_pending}} Rhodium Services{{reset}}\n"
    @for service in rh-swaybg rh-waybar rh-mako; do \
    	if systemctl --user is-active "$$service.service" >/dev/null 2>&1; then \
    		printf "  {{green}}{{sym_success}} %s{{reset}}\n" "$$service"; \
    	else \
    		printf "  {{red}}{{sym_down}} %s{{reset}}\n" "$$service"; \
    	fi; \
    done
    @printf "\n"
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"

# List current generation details
generation:
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "{{cyan}}{{sym_success}} SYSTEM GENERATIONS{{reset}}\n"
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "\n"
    sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -10

# Check for backup files in config
check-backups:
    @printf "{{yellow}}{{sym_pending}} Scanning for backup files...{{reset}}\n"
    @printf "\n"
    @backup_count=0; \
    while IFS= read -r -d '' file; do \
    	size=$$(du -h "$$file" | cut -f1); \
    	age=$$(( ($$(date +%s) - $$(stat -c %Y "$$file")) / 86400 )); \
    	printf "  {{yellow}}{{sym_partial}} %s{{reset}}\n" "$${file#{{home_dir}}/.config/}"; \
    	printf "     Size: %s | Age: %s days\n" "$$size" "$$age"; \
    	((backup_count++)); \
    done < <(find "{{home_dir}}/.config" -type f \( -name "*.backup" -o -name "*.bkp" \) -print0 2>/dev/null); \
    if [ $$backup_count -eq 0 ]; then \
    	printf "  {{green}}{{sym_success}} No backup files found{{reset}}\n"; \
    else \
    	printf "\n"; \
    	printf "Total: %s backup files\n" "$$backup_count"; \
    fi

# Find orphaned configuration files
orphans:
    @printf "{{yellow}}{{sym_pending}} Analyzing configuration orphans...{{reset}}\n"
    @printf "\n"
    @installed_pkgs=$$(mktemp); \
    nix-env -q | cut -d- -f1 | sort -u > "$$installed_pkgs"; \
    home-manager packages 2>/dev/null | grep -E "^[a-zA-Z0-9-]+$$" | sort -u >> "$$installed_pkgs" || true; \
    orphan_count=0; \
    while IFS= read -r -d '' dir; do \
    	dirname=$$(basename "$$dir"); \
    	if [[ "$$dirname" =~ ^(systemd|fontconfig|gtk-[0-9]|user-dirs|mimeapps|dconf|pulse)$$ ]]; then \
    		continue; \
    	fi; \
    	if ! grep -q "^$$dirname$$" "$$installed_pkgs"; then \
    		size=$$(du -sh "$$dir" 2>/dev/null | cut -f1); \
    		printf "  {{yellow}}{{sym_partial}} %s [%s]{{reset}}\n" "$$dirname" "$$size"; \
    		((orphan_count++)); \
    	fi; \
    done < <(find "{{home_dir}}/.config" -maxdepth 1 -type d ! -path "{{home_dir}}/.config" -print0); \
    rm -f "$$installed_pkgs"; \
    if [ $$orphan_count -eq 0 ]; then \
    	printf "  {{green}}{{sym_success}} No orphaned configurations found{{reset}}\n"; \
    else \
    	printf "\n"; \
    	printf "Total: %s potential orphans\n" "$$orphan_count"; \
    	printf "Use 'just clean-orphans' to remove them\n"; \
    fi

# Check for untracked files in repository
untracked:
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "{{cyan}}{{sym_success}} UNTRACKED FILES{{reset}}\n"
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"
    @printf "\n"
    @untracked_files=$$(git -C {{ flake_path }} ls-files --others --exclude-standard); \
    if [ -z "$$untracked_files" ]; then \
    	printf "{{green}}{{sym_success}} Repository is clean{{reset}}\n"; \
    else \
    	count=$$(echo "$$untracked_files" | wc -l); \
    	printf "{{yellow}}{{sym_partial}} Found %s untracked files:{{reset}}\n" "$$count"; \
    	printf "\n"; \
    	echo "$$untracked_files" | while IFS= read -r file; do \
    		size=$$(du -h "{{ flake_path }}/$$file" 2>/dev/null | cut -f1 || echo "?"); \
    		printf "  {{cyan}}{{sym_bullet}} %s [%s]{{reset}}\n" "$$file" "$$size"; \
    	done; \
    fi
    @printf "\n"
    @printf "{{cyan}}{{bar_heavy}}{{reset}}\n"

# Remove orphaned configuration directories [interactive]
clean-orphans:
    @printf "{{yellow}}{{sym_partial}} This will remove orphaned configuration directories{{reset}}\n"
    @printf "Press Ctrl+C to cancel\n"
    @printf "\n"
    @installed_pkgs=$$(mktemp); \
    nix-env -q | cut -d- -f1 | sort -u > "$$installed_pkgs"; \
    home-manager packages 2>/dev/null | grep -E "^[a-zA-Z0-9-]+$$" | sort -u >> "$$installed_pkgs" || true; \
    removed_count=0; \
    while IFS= read -r -d '' dir; do \
    	dirname=$$(basename "$$dir"); \
    	if [[ "$$dirname" =~ ^(systemd|fontconfig|gtk-[0-9]|user-dirs|mimeapps|dconf|pulse)$$ ]]; then \
    		continue; \
    	fi; \
    	if ! grep -q "^$$dirname$$" "$$installed_pkgs"; then \
    		size=$$(du -sh "$$dir" 2>/dev/null | cut -f1); \
    		printf "Remove %s [%s]? [y/N] " "$$dirname" "$$size"; \
    		read -r response; \
    		if [[ "$$response" =~ ^[Yy]$$ ]]; then \
    			rm -rf "$$dir"; \
    			printf "  {{green}}{{sym_success}} Removed{{reset}}\n"; \
    			((removed_count++)); \
    		else \
    			printf "  Skipped\n"; \
    		fi; \
    	fi; \
    done < <(find "{{home_dir}}/.config" -maxdepth 1 -type d ! -path "{{home_dir}}/.config" -print0); \
    rm -f "$$installed_pkgs"; \
    printf "\n"; \
    printf "{{green}}{{sym_success}} Removed %s orphaned directories{{reset}}\n" "$$removed_count"

# Clean all backup files
clean-backups:
    @printf "{{yellow}}{{sym_partial}} This will remove all .backup and .bkp files{{reset}}\n"
    @printf "Press Ctrl+C to cancel\n"
    @printf "\n"
    @sleep 2
    @count=$$(find "{{home_dir}}/.config" -type f \( -name "*.backup" -o -name "*.bkp" \) -delete -print | wc -l); \
    printf "{{green}}{{sym_success}} Removed %s backup files{{reset}}\n" "$$count"

# Update application caches
update-caches:
    @printf "\n"
    @printf "{{yellow}}{{sym_pending}} Updating application caches...{{reset}}\n"
    @{{modules_path}}/cache/build-caches.sh
    @python3 {{modules_path}}/cache/build-icons-cache.py

# Rollback to previous generation
rollback:
    @printf "{{yellow}}{{sym_partial}} Rolling back to previous generation...{{reset}}\n"
    sudo nixos-rebuild switch --rollback
    @printf "{{green}}{{sym_success}} Rollback complete{{reset}}\n"

# Format all nix files
fmt:
    @printf "{{yellow}}{{sym_pending}} Formatting Nix files...{{reset}}\n"
    @count=$$(find {{ flake_path }} -name "*.nix" -type f | wc -l); \
    find {{ flake_path }} -name "*.nix" -type f -exec nixfmt {} +; \
    printf "{{green}}{{sym_success}} Formatted %s files{{reset}}\n" "$$count"
