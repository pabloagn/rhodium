# Default recipe shows available commands
default:
    @just --list

# Set default shell for recipes
set shell := ["bash", "-euo", "pipefail", "-c"]

# Configuration
hostname := `hostname`
flake_path := "."

# Build and switch NixOS configuration
switch host=hostname: (_pre-build host) (_build-switch host) (_post-build host)
    @echo "✓ System rebuild complete!"

# Build without switching (test build)
build host=hostname: (_pre-build host)
    sudo nixos-rebuild build --flake {{ flake_path }}#{{ host }}
    @echo "✓ Build successful (not activated)"

# Rebuild and boot into new generation
boot host=hostname: (_pre-build host)
    sudo nixos-rebuild boot --flake {{ flake_path }}#{{ host }}
    @echo "✓ Will boot into new generation on next reboot"

# Dry run - show what would be built
dry-run host=hostname:
    sudo nixos-rebuild dry-build --flake {{ flake_path }}#{{ host }}

# Update flake inputs
update:
    nix flake update
    @echo "✓ Flake inputs updated"

# Update specific input
update-input input:
    nix flake update {{ input }}
    @echo "✓ Updated input: {{ input }}"

# Garbage collect old generations
gc days="7":
    sudo nix-collect-garbage --delete-older-than {{ days }}d
    nix-collect-garbage --delete-older-than {{ days }}d
    @echo "✓ Garbage collected generations older than {{ days }} days"

# Show current system generation
generation:
    nixos-rebuild list-generations | head -10

# Private recipe for pre-build tasks
_pre-build host:
    @echo "→ Pre-build checks for {{ host }}..."
    @# Add your pre-build checks here
    @# Example: check if flake.nix is valid
    @nix flake check {{ flake_path }} || echo "⚠ Flake check failed, continuing anyway..."

# Private recipe for the actual build/switch
_build-switch host:
    @echo "→ Building and switching to new generation..."
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }}

# Private recipe for post-build tasks
_post-build host:
    @echo "→ Running post-build tasks..."
    @# Only reload services if we're in a Wayland session
    @if [ -n "${WAYLAND_DISPLAY:-}" ]; then \
        echo "  → Reloading Wayland services..."; \
        systemctl --user daemon-reload; \
        for service in rh-swaybg rh-waybar rh-mako; do \
            echo "    → Restarting $$service..."; \
            systemctl --user restart "$$service.service" || true; \
        done; \
        echo "  ✓ Services reloaded"; \
    else \
        echo "  → Not in Wayland session, skipping service reload"; \
    fi
    @# Slow down Niri
    niri msg action do-screen-transition --delay-ms 200


# Development: rebuild with verbose output
dev host=hostname:
    sudo nixos-rebuild switch --flake {{ flake_path }}#{{ host }} --show-trace -L

# Check which services would be affected
check-services:
    @echo "Services that would be reloaded:"
    @systemctl --user list-units 'rh-*.service' --no-pager

# Rollback to previous generation
rollback:
    sudo nixos-rebuild switch --rollback
    @echo "✓ Rolled back to previous generation"

# Format all nix files
fmt:
    nixfmt flake.nix
    find . -name "*.nix" -type f -exec nixfmt {} +
    @echo "✓ Formatted all .nix files"

# Alias for common operation
rebuild: switch

