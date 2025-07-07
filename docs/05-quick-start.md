---
layout: default
title: Quick Start
permalink: /05-quick-start/
---

# Quick Start

Get up and running with Rhodium quickly using either the built-in justfile or direct Nix flake commands.

## Installation Methods

There are two main ways to interact with Rhodium:
- Using the built-in justfile
- Using nix flake commands directly

## Using Just

This system includes a comprehensive justfile at the flake root for system management. After cloning the repository, you can use any of the 20+ pre-scripted commands:

### Basic Commands

```bash
just                    # Show available commands
just fast hostname      # Fast rebuild and switch with minimal output
just switch hostname    # Build and switch NixOS configuration
just build hostname     # Build without switching [test build]
just boot hostname      # Rebuild and boot into new generation
just dry hostname       # Dry run - show what would be built
just dev hostname       # Development rebuild with verbose output
```

### Update Commands

```bash
just update             # Update all flake inputs
just update-input name  # Update specific flake input
just flake-info         # Show flake metadata
```

### Maintenance Commands

```bash
just gc                 # Clean all garbage
just gc-keep 5          # Remove old generations keeping N most recent
just gc-days 7          # Traditional time-based garbage collection
just health             # Show system health status
just generation         # List current generation details
just rollback           # Rollback to previous generation
```

### Development Commands

```bash
just fmt                # Format all nix files
just reload-services    # Reload user services
just source-user-vars   # Source user environment variables
just check-backups      # Check for backup files in config
just orphans            # Find orphaned configuration files
just untracked          # Check for untracked files in repository
```

### Cleanup Commands

```bash
just clean-orphans      # Remove orphaned configuration directories [interactive]
just clean-backups      # Clean all backup files
just update-caches      # Update application caches
```

## Using Nix Directly

You can directly run the typical nix flake commands instead of relying on the justfile.

### Quick Installation

After setting up a basic NixOS system, you can create a new derivation using this flake:

```bash
sudo nixos-rebuild switch --flake 'github:pabloagn/rhodium#hostname'
```

Where hostname is the target host you want to use. Consult the hosts directory for the full specification.

### Local Development

Clone the repository and test before committing to a full derivation:

```bash
# Using HTTPS
git clone https://github.com/pabloagn/rhodium

# Using SSH
git clone git@github.com:pabloagn/rhodium

# Navigate to the directory
cd rhodium
```

### Safe Testing Process

#### 1. Build Test
Start with nixos-rebuild build to check configuration:

```bash
sudo nixos-rebuild build --flake .#your-hostname
```

This quickly checks if your configuration builds successfully without applying changes. It's fast and catches syntax errors and missing packages.

#### 2. Test Build
When build succeeds, use nixos-rebuild test:

```bash
sudo nixos-rebuild test --flake .#your-hostname
```

This creates a temporary boot entry with your changes. If something breaks, simply reboot to return to your stable system. The temporary entry is automatically removed after a successful reboot.

#### 3. Permanent Switch
When you're ready, build the new derivation and switch:

```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

This makes the changes permanent, with the ability to roll back from GRUB if needed.

## First Steps After Installation

### 1. Verify Installation
```bash
just generation     # Check system generation
just health         # Verify system health
just                # List available commands
```

### 2. Customize Configuration
- Edit host-specific configuration in `hosts/your-hostname/`
- Modify user configuration in `home/`
- Update system packages in `system/`

### 3. Apply Changes
```bash
just build your-hostname    # Test changes
just switch your-hostname   # Apply changes
```

### 4. Explore Features
- Check available tools and applications
- Explore keybindings and shortcuts
- Review documentation for advanced features

## Troubleshooting

### Build Failures
```bash
just build hostname     # Check for syntax errors
just gc                 # Clean and rebuild
```

### System Issues
```bash
just rollback           # Rollback to previous generation
just health             # Check system health
journalctl -f           # View system logs
```

### Configuration Problems
```bash
just orphans            # Check for orphaned files
just clean-backups      # Clean backup files
just fmt                # Format configuration files
```
