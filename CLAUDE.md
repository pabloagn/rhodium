# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Rhodium is a hypermodular, declarative NixOS system built using Nix flakes. It combines system-level configuration with Home Manager for user-specific configurations, using a profile-based approach for 150+ curated packages. The architecture separates concerns between hosts, users, modules, and data.

## Architecture

### Core Structure

- **`flake.nix`**: Main entry point defining all inputs, outputs, and NixOS configurations
- **`hosts/`**: Per-host NixOS system configurations (e.g., `host_001/`, `host_002/`)
- **`users/`**: Per-user Home Manager configurations (e.g., `user_001/`)
- **`modules/`**: System-level NixOS modules organized by category (boot, desktop, hardware, security, services, etc.)
- **`home/`**: User-level Home Manager modules (apps, desktop, development, environment, shells, etc.)
- **`data/`**: Declarative user and host data separated from logic
  - `data/users/users.nix`: User account definitions
  - `data/hosts/hosts.nix`: Host metadata (hostname, monitor config, etc.)
  - `data/users/preferences/`: User preferences (apps, behavior, metadata, theme)
  - `data/users/extras/`: User-specific data (apps, bookmarks, profiles)
- **`lib/`**: Custom Nix library functions (formatters, generators, parsers)
- **`overlays/`**: Nix package overlays
- **`build/recipes/`**: Shell scripts for system management (prefixed with `rh-`)

### Key Design Patterns

1. **Data-Logic Separation**: User and host metadata live in `data/` and are imported into `flake.nix` as structured data, then passed to modules via `specialArgs` and `extraSpecialArgs`

2. **Multi-Channel Nixpkgs**: Uses three nixpkgs channels:
   - `nixpkgs` (25.05 stable): Primary system packages
   - `nixpkgs-unstable`: Cutting-edge packages
   - `nixpkgs-shell`: Shell environment packages (25.11)

3. **Theme System**: Centralized theming through `home/assets/themes/` with user preferences in `data/users/preferences/theme.nix`

4. **Profile-Based Configuration**: Modular imports allow granular control over system features

5. **External Inputs**: Integrates custom flakes:
   - `chiaroscuro`: Theme package
   - `rhodium-alloys`: Fish and Yazi plugins
   - `iridium-rh`: Private configuration (SSH)
   - `kanso-nvim`: Custom Neovim configuration

### Special Args Flow

System-level modules (`modules/`) receive via `specialArgs`:
- `pkgs-unstable`, `inputs`, `rhodiumLib`, `users`, `host`

User-level modules (`home/`) receive via `extraSpecialArgs`:
- `pkgs-unstable`, `inputs`, `rhodiumLib`, `userData`, `user`, `host`, `theme`, `targetTheme`, `chiaroscuroTheme`, `userPreferences`, `userExtras`, `fishPlugins`, `yaziPlugins`, `mkModule`, `mkPkgModule`

## Build and Deployment Commands

All commands use `just` (see `justfile`). Host identifiers: `host_001` (justine), `host_002` (alexandria).

### Primary Commands

```bash
# Fast rebuild and switch (minimal output, skip checks)
just switch-fast host_001

# Standard rebuild and switch
just switch host_001

# Build only (no activation)
just build host_001

# Prepare for next boot
just boot host_001

# Dry-run (show what would be built)
just build-dry host_001
```

### Development Commands

```bash
# Check flake syntax and evaluate
just check

# Format all .nix files (uses nixfmt-rfc-style)
just fmt

# Profile build time
just profile-build host_001

# Show what would be built
just show-derivation host_001
```

### Maintenance Commands

```bash
# Update all flake inputs
just update

# Update specific input
just update-input nixpkgs

# Garbage collection (keep last 5 generations)
just gc-keep 5

# Roll back to previous generation
just rollback

# Check system health
just health

# Reload user systemd services
just reload-services
```

### Diagnostics Commands

```bash
# Find .backup files created by Home Manager
just find-backups

# Find orphaned config directories
just find-orphans

# Find untracked files
just find-untracked

# Clean backup files
just clean-backups
```

## Common Development Workflows

### Adding a New Host

1. Create host directory: `hosts/host_00X/`
2. Add `default.nix` and `hardware-configuration.nix`
3. Add host metadata to `data/hosts/hosts.nix`
4. Add NixOS configuration entry in `flake.nix` under `nixosConfigurations`
5. Build: `just switch host_00X`

### Adding a New User

1. Create user directory: `users/user_00X/`
2. Add user metadata to `data/users/users.nix`
3. Add user preferences to `data/users/preferences/`
4. Add Home Manager configuration entry in `flake.nix`
5. Link user to host in the host's `nixosConfigurations` entry

### Modifying System Modules

System modules are in `modules/` and imported by hosts. After changes:

```bash
just check              # Verify syntax
just build-dry host_001 # Preview changes
just switch host_001    # Apply changes
```

### Modifying Home Manager Modules

Home modules are in `home/` and imported by users. After changes, same workflow as system modules.

### Working with Themes

1. Themes are defined in `home/assets/themes/`
2. User theme preference in `data/users/preferences/theme.nix`
3. Theme is resolved in `flake.nix` via `getThemeConfig` function
4. Theme data passed to home modules as `theme` special arg

### Debugging Build Failures

When `just switch-fast host_001` fails:

1. Check full error: `journalctl -u home-manager-pabloagn.service -n 200`
2. For Home Manager file conflicts, note that `backupFileExtension = "backup"` is already set in `flake.nix` (lines 213, 254)
3. Use verbose build: `just build-dev host_001`
4. Verify flake: `just check`

## Important Notes

### Home Manager Backups

The system automatically backs up conflicting files with `.backup` extension. This is configured in `flake.nix` at the `home-manager.backupFileExtension` option.

### Git Status

The configuration is a git repository. Dirty working tree warnings during builds are normal and informational.

### Flake Structure

- Uses `flake-parts` for modular flake organization
- Supports both NixOS configurations (`nixosConfigurations`) and standalone Home Manager (`homeConfigurations`)
- Home Manager is integrated as a NixOS module, not standalone

### Security

- Uses `sops-nix` for secrets management
- Secrets should not be committed to the repository
- Private inputs use SSH (see `iridium-rh` input)

### Custom Library (`rhodiumLib`)

Provides helper functions available to all modules:
- `generators.moduleGenerators.mkModule`: Create standard modules
- `generators.moduleGenerators.mkPkgModule`: Create package-based modules
- `generators.desktopGenerators`: Desktop entry generators
- `formatters.iconFormatter`: Icon formatting utilities
- `parsers.luaParsers`: Lua configuration parsers

Access in modules via the `rhodiumLib` argument.
