# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ▲ RHODIUM SYSTEM MANAGEMENT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ─────────────────────────────────────────────────────────────────────────────
# ⟡ CONFIGURATION
# ─────────────────────────────────────────────────────────────────────────────

set shell := ["bash", "-euo", "pipefail", "-c"]
set positional-arguments := true

hostname := `hostname`
flake_path := "."
username := `echo $USER`
config_dir := `echo $HOME` + "/.config"
cache_home := `echo ${XDG_CACHE_HOME:-$HOME/.cache}`
nix_profile := "/nix/var/nix/profiles"

# Default recipe shows available commands
default:
    @just --list

# Build and switch NixOS configuration
switch host=hostname: && update-caches
    @echo "⟡ Pre-build validation for {{ host }}"
    @if nix flake check {{ flake_path }} 2>/dev/null; then \
    	echo "  ▲ Flake validation passed"; \
    else \
    	echo "  ◐ Flake validation failed [continuing anyway]"; \
    fi
    @echo "⟡ Building and switching configuration..."
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }}
    @echo "⟡ Running post-build tasks..."
    @if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then \
    	echo "  ▪ Loading session variables"; \
    	source "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"; \
    fi
    @if [ -n "${WAYLAND_DISPLAY:-}" ]; then \
    	echo "  ▪ Reloading Wayland services"; \
    	systemctl --user daemon-reload; \
    	for service in rh-swaybg rh-waybar rh-mako; do \
    		systemctl --user restart "$$service.service" 2>/dev/null || true; \
    	done; \
    fi
    @command -v niri >/dev/null 2>&1 && niri msg action do-screen-transition --delay-ms 200 2>/dev/null || true
    @echo "▲ System rebuild complete"

# Build without switching [test build]
build host=hostname:
    @echo "⟡ Building configuration for {{ host }}..."
    sudo nixos-rebuild build --flake {{ flake_path }}#{{ host }}
    @echo "▲ Build successful [not activated]"

# Rebuild and boot into new generation
boot host=hostname:
    @echo "⟡ Building boot configuration for {{ host }}..."
    sudo nixos-rebuild boot --flake {{ flake_path }}#{{ host }}
    @echo "▲ Will boot into new generation on next reboot"

# Dry run - show what would be built
dry host=hostname:
    @echo "⟡ Dry run for {{ host }}..."
    sudo nixos-rebuild dry-build --flake {{ flake_path }}#{{ host }}

# Fast rebuild with minimal output
fast host=hostname: && update-caches
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }} --fast

# Development rebuild with verbose output
dev host=hostname:
    @echo "◐ Development build with trace output..."
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }} --show-trace -L

# Update all flake inputs
update:
    @echo "⟡ Updating all flake inputs..."
    nix flake update
    @echo "▲ Flake inputs updated"
    @echo ""
    @echo "Input changes:"
    @git -C {{ flake_path }} diff flake.lock | grep -E "^\+" | grep -E "(lastModified|narHash)" | head -10 || true

# Update specific flake input
update-input input:
    @echo "⟡ Updating input: {{ input }}..."
    nix flake update {{ input }}
    @echo "▲ Updated input: {{ input }}"

# Show flake metadata
flake-info:
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo "▲ FLAKE INFORMATION"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo ""
    nix flake metadata {{ flake_path }}

# Remove old generations keeping N most recent [default: 5]
gc-keep generations="5":
    @echo "⟡ Analyzing generations..."
    @current_gen=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print $1}'); \
    total_gens=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l); \
    echo "  Current generation: $current_gen"; \
    echo "  Total generations: $total_gens"; \
    echo "  Generations to keep: {{ generations }} [plus current]"; \
    echo ""; \
    gens_to_keep=$(({{ generations }} + 1)); \
    if [ $total_gens -le $gens_to_keep ]; then \
    	echo "◐ Nothing to collect [already at or below target]"; \
    	exit 0; \
    fi; \
    echo "⟡ Collecting garbage..."; \
    keep_from=$((current_gen - {{ generations }})); \
    for gen in $(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | awk '{print $1}'); do \
    	if [ "$$gen" -lt "$$keep_from" ] && [ "$$gen" != "$$current_gen" ]; then \
    		echo "  Removing generation $$gen..."; \
    		sudo nix-env --delete-generations $$gen -p /nix/var/nix/profiles/system 2>/dev/null || true; \
    	fi; \
    done; \
    echo ""; \
    echo "⟡ Running garbage collector..."; \
    sudo nix-collect-garbage; \
    nix-collect-garbage; \
    new_total=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l); \
    echo ""; \
    echo "▲ Garbage collection complete"; \
    echo "  Remaining generations: $$new_total"

# Traditional time-based garbage collection
gc-days days="7":
    @echo "⟡ Collecting generations older than {{ days }} days..."
    sudo nix-collect-garbage --delete-older-than {{ days }}d
    nix-collect-garbage --delete-older-than {{ days }}d
    @echo "▲ Garbage collection complete"

# Show system health status
health:
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo "▲ SYSTEM HEALTH"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo ""
    @echo "⟡ Flake Status"
    @if git -C {{ flake_path }} diff --quiet; then \
    	echo "  ▲ No uncommitted changes"; \
    else \
    	echo "  ◐ Uncommitted changes present"; \
    fi
    @untracked=$(git -C {{ flake_path }} ls-files --others --exclude-standard | wc -l); \
    if [ "$$untracked" -eq 0 ]; then \
    	echo "  ▲ No untracked files"; \
    else \
    	echo "  ◐ $$untracked untracked files"; \
    fi
    @echo ""
    @echo "⟡ Disk Usage"
    @store_size=$(du -sh /nix/store 2>/dev/null | cut -f1); \
    echo "  Nix store: $$store_size"
    @root_usage=$(df -h / | tail -1 | awk '{print $5}'); \
    echo "  Root partition: $$root_usage used"
    @echo ""
    @echo "⟡ Generations"
    @current_gen=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print $1}'); \
    total_gens=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l); \
    echo "  Current: $$current_gen"; \
    echo "  Total: $$total_gens"
    @echo ""
    @echo "⟡ Rhodium Services"
    @for service in rh-swaybg rh-waybar rh-mako; do \
    	if systemctl --user is-active "$$service.service" >/dev/null 2>&1; then \
    		echo "  ▲ $$service"; \
    	else \
    		echo "  ▼ $$service"; \
    	fi; \
    done
    @echo ""
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# List current generation details
generation:
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo "▲ SYSTEM GENERATIONS"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo ""
    sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -10

# Check for backup files in config
check-backups:
    @echo "⟡ Scanning for backup files..."
    @echo ""
    @backup_count=0; \
    while IFS= read -r -d '' file; do \
    	size=$$(du -h "$$file" | cut -f1); \
    	age=$$(( ($$(date +%s) - $$(stat -c %Y "$$file")) / 86400 )); \
    	echo "  ◐ $${file#$$HOME/.config/}"; \
    	echo "     Size: $$size | Age: $$age days"; \
    	((backup_count++)); \
    done < <(find "$$HOME/.config" -type f \( -name "*.backup" -o -name "*.bkp" \) -print0 2>/dev/null); \
    if [ $$backup_count -eq 0 ]; then \
    	echo "  ▲ No backup files found"; \
    else \
    	echo ""; \
    	echo "Total: $$backup_count backup files"; \
    fi

# Find orphaned configuration files
orphans:
    @echo "⟡ Analyzing configuration orphans..."
    @echo ""
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
    		echo "  ◐ $$dirname [$$size]"; \
    		((orphan_count++)); \
    	fi; \
    done < <(find "$$HOME/.config" -maxdepth 1 -type d ! -path "$$HOME/.config" -print0); \
    rm -f "$$installed_pkgs"; \
    if [ $$orphan_count -eq 0 ]; then \
    	echo "  ▲ No orphaned configurations found"; \
    else \
    	echo ""; \
    	echo "Total: $$orphan_count potential orphans"; \
    	echo "Use 'just clean-orphans' to remove them"; \
    fi

# Check for untracked files in repository
untracked:
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo "▲ UNTRACKED FILES"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo ""
    @untracked_files=$$(git -C {{ flake_path }} ls-files --others --exclude-standard); \
    if [ -z "$$untracked_files" ]; then \
    	echo "▲ Repository is clean"; \
    else \
    	count=$$(echo "$$untracked_files" | wc -l); \
    	echo "◐ Found $$count untracked files:"; \
    	echo ""; \
    	echo "$$untracked_files" | while IFS= read -r file; do \
    		size=$$(du -h "{{ flake_path }}/$$file" 2>/dev/null | cut -f1 || echo "?"); \
    		echo "  ▪ $$file [$$size]"; \
    	done; \
    fi
    @echo ""
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Remove orphaned configuration directories [interactive]
clean-orphans:
    @echo "◐ This will remove orphaned configuration directories"
    @echo "Press Ctrl+C to cancel"
    @echo ""
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
    		printf "Remove $$dirname [$$size]? [y/N] "; \
    		read -r response; \
    		if [[ "$$response" =~ ^[Yy]$$ ]]; then \
    			rm -rf "$$dir"; \
    			echo "  ▲ Removed"; \
    			((removed_count++)); \
    		else \
    			echo "  Skipped"; \
    		fi; \
    	fi; \
    done < <(find "$$HOME/.config" -maxdepth 1 -type d ! -path "$$HOME/.config" -print0); \
    rm -f "$$installed_pkgs"; \
    echo ""; \
    echo "▲ Removed $$removed_count orphaned directories"

# Clean all backup files
clean-backups:
    @echo "◐ This will remove all .backup and .bkp files"
    @echo "Press Ctrl+C to cancel"
    @echo ""
    @sleep 2
    @count=$$(find "$$HOME/.config" -type f \( -name "*.backup" -o -name "*.bkp" \) -delete -print | wc -l); \
    echo "▲ Removed $$count backup files"

# Update application caches
update-caches:
    @echo ""
    @echo "⟡ Updating application caches..."
    @APP_DIR="$$HOME/.local/share/applications"; \
    CACHE_DIR="$${XDG_CACHE_HOME:-$$HOME/.cache}/rhodium-apps"; \
    CACHE_FILE="$$CACHE_DIR/formatted_apps.cache"; \
    if [ -d "$$APP_DIR" ]; then \
    	mkdir -p "$$CACHE_DIR"; \
    	rm -f "$$CACHE_FILE"; \
    	echo "  ▪ Rebuilding rhodium-apps cache"; \
    	temp_cache=$$(mktemp); \
    	for file in "$$APP_DIR"/rh-*.desktop; do \
    		[[ -f "$$file" ]] || continue; \
    		name=""; \
    		entry_type="app"; \
    		categories=""; \
    		while IFS='=' read -r key value; do \
    			case "$$key" in \
    				"Name") name="$$value" ;; \
    				"X-Entry-Type") entry_type="$$value" ;; \
    				"X-Category") categories="$$value" ;; \
    			esac; \
    		done < "$$file"; \
    		if [[ -n "$$categories" ]]; then \
    			IFS=';' read -ra cat_array <<< "$$categories"; \
    			formatted_cats=""; \
    			for cat in "$${cat_array[@]}"; do \
    				cat="$${cat#"$${cat%%[![:space:]]*}"}"; \
    				cat="$${cat%"$${cat##*[![:space:]]}"}"; \
    				[[ -n "$$cat" ]] && formatted_cats+="$${formatted_cats:+, }$${cat^}"; \
    			done; \
    			categories="$$formatted_cats"; \
    		else \
    			categories="App"; \
    		fi; \
    		printf "⟡ %-35s %-20s %s\t%s\n" "$$name" "$${entry_type^}" "$$categories" "$$file" >> "$$temp_cache"; \
    	done; \
    	sort -k2,2 "$$temp_cache" > "$$CACHE_FILE"; \
    	rm -f "$$temp_cache"; \
    	count=$$(wc -l < "$$CACHE_FILE" 2>/dev/null || echo 0); \
    	echo "  ▲ Cached $$count applications"; \
    fi; \
    echo "  ▪ Clearing desktop file cache"; \
    rm -f "$$HOME/.cache/applications/desktop-file-cache" 2>/dev/null || true; \
    update-desktop-database "$$APP_DIR" 2>/dev/null || true

# Force rebuild yazi image cache for directory
yazi-cache dir=".":
    @echo "⟡ Checking yazi cache capabilities..."
    @if command -v yazi >/dev/null 2>&1; then \
    	echo "◐ Yazi CLI caching not available"; \
    	echo "Image caching occurs on directory access"; \
    	echo ""; \
    	echo "⟡ Pre-generating thumbnails..."; \
    	thumb_dir="$${XDG_CACHE_HOME:-$$HOME/.cache}/yazi/thumbnails"; \
    	mkdir -p "$$thumb_dir"; \
    	count=0; \
    	while IFS= read -r -d '' img; do \
    		hash=$$(echo -n "$$img" | sha256sum | cut -d' ' -f1); \
    		thumb="$$thumb_dir/$${hash}.jpg"; \
    		if [ ! -f "$$thumb" ]; then \
    			convert "$$img" -thumbnail 500x500 "$$thumb" 2>/dev/null && ((count++)) || true; \
    		fi; \
    	done < <(find "{{ dir }}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) -print0 2>/dev/null); \
    	echo "▲ Generated $$count new thumbnails"; \
    else \
    	echo "▼ Yazi not found"; \
    fi

# Rollback to previous generation
rollback:
    @echo "◐ Rolling back to previous generation..."
    sudo nixos-rebuild switch --rollback
    @echo "▲ Rollback complete"

# Format all nix files
fmt:
    @echo "⟡ Formatting Nix files..."
    @count=$$(find {{ flake_path }} -name "*.nix" -type f | wc -l); \
    find {{ flake_path }} -name "*.nix" -type f -exec nixfmt {} +; \
    echo "▲ Formatted $$count files"
