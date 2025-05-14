# NixOS Dotfiles

[NixOS Flake](https://wiki.nixos.org/wiki/Flakes) for my NixOS Systems.

## Flake Structure

### Flake Architecture

```text
rhodium/
├── assets/                      # Static resources used by the system
│   ├── colors/                  # Color schemes and definitions
│   ├── desktop/                 # Desktop environment resources
│   ├── development/             # Development tool configurations
│   ├── dictionaries/            # Dictionary files for spell checking
│   ├── fonts/                   # Font files and metadata
│   ├── icons/                   # Icon sets and themes
│   ├── images/                  # Image resources
│   ├── media/                   # Media files
│   ├── security/                # Security-related resources
│   ├── shells/                  # Shell-specific resources
│   ├── sounds/                  # Sound files
│   ├── splash/                  # Boot splash screens
│   ├── templates/               # Template files for various purposes
│   ├── themes/                  # System themes and visual styling
│   └── tokens/                  # Design tokens for consistency
│
├── dev/                         # Development-specific configurations and tools
│   ├── flakes/                  # Development flakes for different environments
│   ├── linters/                 # Linter configurations
│   ├── shells/                  # Development shell configurations
│   └── tools/                   # Development tools
│
├── env/                         # Environment-specific configurations
│   └── default.nix              # Default environment settings
│
├── flakeModules/                # Modular components for the flake
│   ├── ci.nix                   # CI/CD configuration
│   ├── containerization.nix     # Container support
│   ├── default.nix              # Default flake module settings
│   ├── devFlakes.nix            # Development flake configurations
│   ├── devShells.nix            # Development shell configurations
│   ├── documentation.nix        # Documentation generation
│   ├── nixos.nix                # NixOS-specific configuration
│   ├── security.nix             # Security settings
│   └── testing.nix              # Testing framework configuration
│
├── flake.nix                    # Main flake definition file
│
├── home/                        # Home Manager configurations for users
│   ├── profiles/                # User profile templates (developer, desktop, etc.)
│   └── roles/                   # Role-based home configurations (admin, developer, etc.)
│
├── hosts/                       # Host-specific configurations
│   ├── common/                  # Common configuration shared by all hosts
│   ├── manifest.nix             # Host deployment manifest (defines all hosts)
│   ├── nixos-desktop/           # Configuration for desktop NixOS hosts
│   ├── nixos-native/            # Configuration for native NixOS hosts
│   ├── nixos-wsl2/              # Configuration for WSL2 NixOS hosts
│   └── roles/                   # Role-based host configurations (server, desktop, etc.)
│
├── lib/                         # Library functions for the NixOS configuration
│   ├── default.nix              # Exports all library functions
│   └── utils.nix                # Host templating and manifest system
│
├── modules/                     # NixOS system modules
│   ├── core/                    # Core system modules
│   │   ├── default.nix          # Main core module import
│   │   ├── shells.nix           # Shell configurations
│   │   ├── user-implementation.nix # User implementation based on roles
│   │   └── user-roles.nix       # User role definitions
│   ├── desktop/                 # Desktop environment modules
│   ├── development/             # Development tool modules
│   ├── profiles/                # System profile modules
│   │   ├── default.nix          # Main profile import
│   │   └── options.nix          # System-wide option definitions
│   ├── security/                # Security-related modules
│   ├── services/                # Service configurations
│   ├── system/                  # Low-level system modules
│   └── themes/                  # Theme configuration modules
│
├── overlays/                    # Nixpkgs overlays
│   ├── default.nix              # Main overlay composition
│   ├── fixes/                   # Fixes for packages
│   ├── packages/                # Custom package definitions
│   │   ├── custom-fonts.nix     # Custom font package definitions
│   │   ├── default.nix          # Package overlay composition
│   │   └── zen-browser.nix      # Zen browser overlay
│   └── services/                # Service overlays
│
├── scripts/                     # Utility scripts
│   ├── aliases/                 # Shell aliases
│   ├── launchers/               # Application launchers
│   └── utilities/               # General utility scripts
│
├── secrets/                     # Secure information (gitignored in production)
│   └── README.md                # Instructions for handling secrets
│
├── tools/                       # Custom tools developed for the system
│   ├── Cargo.lock               # Rust dependency lock file
│   ├── Cargo.toml               # Rust workspace definition
│   ├── cli/                     # Command-line interface tools
│   └── color-provider/          # Color scheme provider tool
│
└── users/                       # User definitions
    ├── default.nix              # User module that imports all users
    └── pabloagn.nix             # Configuration for user pabloagn
```

### Flake Components

- `assets/`: Contains all static resources used across the system. These are organized by type to make them easy to find and reference from modules. Assets include visual elements, configuration data, and resources that don't change frequently.
- `dev/`: Development environment configurations, separate from the main system configuration. This allows for isolated development environments without affecting the main system.
- `flakeModules/`: Breaks the flake functionality into modular components that can be composed together. This makes the flake more maintainable and allows reuse across projects.
- `home/`: Home Manager configurations that define user environments. Organized by profiles (types of users) and roles (permissions and tools needed for different job functions).
- `hosts/`: Host-specific configurations, with the new manifest.nix file defining all hosts in one place. Host templates are defined in lib/utils.nix and referenced in the manifest.
- `lib/`: Library functions that support the NixOS configuration, particularly the host templating system that generates host configurations from the manifest.
- `modules/`: NixOS system modules organized by function. These implement system-wide configurations and options defined in modules/profiles/options.nix.
- `overlays/`: Package customizations and additions, organized by purpose (fixes, new packages, service modifications).
- `scripts/`: Utility scripts that support system operation but aren't part of the NixOS configuration itself.
- `tools/`: Custom tools developed specifically for this system, with their source code and build configurations.
- `users/`: User definitions that specify which users exist on which hosts and what roles they have. The role-based system ensures consistent permissions and tool access.
