# System Hosts

This directory contains configuration for System Hosts.

## Contents

- common
- docker
- nixos-native
- nixos-wsl2

## Host Configuration System

### Host Types

Each subdirectory (nixos-wsl, nixos-desktop, etc.) contains the base configuration
for that type of host. These configurations are automatically applied to all hosts
of the matching type defined in `manifest.nix`.

### How Host Configurations Apply

1. The `manifest.nix` file defines hosts with their "type" attribute
2. The `Library/mk-host.nix` function processes this manifest
3. For each host, it:
   - Includes the base configuration from the host type directory
   - Applies any extra modules specified in the host definition
   - Creates a complete NixOS system configuration

### Example

For a host defined with `type = "desktop"` in manifest.nix:

- Base configuration from `Hosts/nixos-desktop/default.nix` is applied
- This sets up hardware, boot, display, and other desktop-specific settings
- Additional modules from the host's `extraModules` are then applied
