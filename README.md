# NixOS Dotfiles

[NixOS Flake](https://wiki.nixos.org/wiki/Flakes) for my NixOS Systems.

## Content

```text
flake/
├── flake.nix                           # Entry point, inputs and outputs
├── flake.lock                          # Lockfile
├── flakeModules/                       # Flake-parts modules
│   ├── default.nix                     # Re-exports all flake modules
│   ├── devshells.nix                   # Development shell configurations
│   ├── nixos.nix                       # NixOS configurations
│   └── devFlakes.nix                   # Development environment flakes
├── hosts/                              # Machine-specific configurations
│   ├── common/                         # Shared across all hosts
│   │   ├── default.nix                 # Entry point for common config
│   │   └── networking.nix              # Common networking settings
│   ├── wsl/                            # WSL2 configuration
│   │   ├── default.nix                 # Main configuration 
│   │   └── hardware-configuration.nix  # WSL2-specific hardware settings
│   ├── native/                         # Native NixOS installation
│   │   ├── default.nix                 # Main configuration
│   │   └── hardware-configuration.nix  # Native hardware detection
│   └── docker/                         # Docker container config
│       ├── default.nix                 # Main configuration
│       └── container-config.nix        # Container-specific settings
├── modules/                            # NixOS system modules (flattened)
│   ├── core/                           # Core system configuration
│   │   ├── default.nix                 # Entry point for core modules
│   │   ├── boot.nix                    # Boot configuration
│   │   └── security.nix                # System security settings
│   ├── desktop/                        # Desktop environment modules
│   │   ├── default.nix                 # Entry point for desktop modules
│   │   ├── fonts.nix                   # Font configuration (company fonts here)
│   │   └── i3.nix                      # i3 window manager configuration
│   ├── development/                    # Development tools modules
│   │   ├── default.nix                 # Entry point for dev modules
│   │   ├── languages/                  # Programming languages
│   │   │   ├── default.nix             # Common language settings
│   │   │   └── rust.nix                # Rust-specific settings
│   │   └── tools/                      # Development tools
│   │       ├── default.nix             # Common tools
│   │       └── git.nix                 # Git configuration
│   └── server/                         # Server configuration modules
│       ├── default.nix                 # Entry point for server modules
│       └── nginx.nix                   # Nginx configuration
├── users/                              # User definitions and permissions
│   ├── default.nix                     # Common user settings
│   └── yourusername.nix                # Your user definition
├── home/                               # Home-manager configurations
│   └──── profiles/                       # User role profiles
│       ├── default.nix                 # Common profile settings
│       └── developer.nix               # Developer profile
├── dev/                                # Development environments
│   ├── flakes/                         # Project-specific dev flakes
│   │   ├── web-stack/                  # Web development flake
│   │   │   └── flake.nix               # Web stack flake definition
│   │   └── data-science/               # Data science flake
│   │       └── flake.nix               # Data science flake definition
│   ├── shells/                         # Reusable development shells
│   │   ├── default.nix                 # Common shell settings
│   │   └── python.nix                  # Python development shell
│   ├── linters/                        # Linter configurations
│   │   ├── default.nix                 # Common linter settings
│   │   └── eslint/                     # ESLint configuration
│   │       ├── default.nix             # ESLint module
│   │       └── .eslintrc.json          # ESLint rules
│   └── tools/                          # Development tools
│       ├── default.nix                 # Common tools
│       └── formatter.nix               # Code formatter config
├── assets/                             # Static assets (no nix files)
│   ├── fonts/                          # Font files
│   │   └── company-font.ttf            # Example company font
│   ├── images/                         # Image files
│   │   └── branding/                   # Company branding
│   │       └── logo.png                # Company logo
│   ├── sounds/                         # Sound files
│   │   └── notification.mp3            # Notification sound
│   └── themes/                         # Theme configurations
│       └── hyprland/                   # Hyprland themes
│           ├── dark.conf               # Dark theme config
│           └── light.conf              # Light theme config
├── scripts/                            # Shared scripts
│   ├── utilities/                      # Utility scripts
│   │   ├── update-system.sh            # System update script
│   │   └── backup.sh                   # Backup script
│   └── aliases/                        # Shell aliases
│       └── default.nix                 # Shell aliases definition
├── env/                                # Environment variables
│   ├── default.nix                     # Common variables
├── secrets/                            # Encrypted secrets
│   └── .gitignore                      # Ignore secrets in git
├── overlays/                           # Package overlays
│   ├── default.nix                     # Common overlay settings
│   └── custom-font.nix                 # Custom font package
└── lib/                                # Helper Nix functions
    ├── default.nix                     # Re-exports all functions
    └── utils.nix                       # Utility functions
```

## Installation

```bash
git clone https://github.com/pabloagn/nixos-dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Key Design Principles

1. **Separation of Concerns**
   - Host-specific vs. shared configurations
   - Hardware vs. software settings
   - System vs. user configuration

2. **Modularity**
   - Feature-based modules
   - Configurable options
   - Conditional inclusion

3. **Admin Control**
   - Centralized management of all user environments
   - Fine-grained access control to development tools
   - Standardized configurations

## Configuration Management

### Host Configuration

Host configurations combine common and machine-specific settings:

```nix
# hosts/machine-name/default.nix
{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "machine-name";
  
  # Enable functional categories
  mySystem.categories = {
    development.enable = true;
    desktop.wm.i3.enable = true;
  };
}
```

### Category Modules

Functional categories group related settings with enable/disable options:

```nix
# modules/categories/development/default.nix
{ config, lib, pkgs, ... }:

with lib;
let 
  cfg = config.mySystem.categories.development;
in {
  options.mySystem.categories.development = {
    enable = mkEnableOption "development environment";
    languages.rust.enable = mkEnableOption "Rust development";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];
    imports = [
      (mkIf cfg.languages.rust.enable ./languages/rust.nix)
    ];
  };
}
```

### User Management

Define users with specific permissions and configurations:

```nix
# users/username.nix
{
  users.users.username = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # Control which development tools the user receives
  myCompany.devAccess.username = {
    webStack.enable = true;
    dataScience.enable = false;
  };
}
```

## Development Environments

### Development Flakes

Standalone project-specific environments:

```nix
# dev/flakes/web-stack/flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let 
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ nodejs yarn ];
          };
        }
      );
    };
}
```

### Linter Configurations

Standardized linting across the organization:

```nix
# dev/linters/eslint/default.nix
{ config, lib, pkgs, ... }:

{
  home.file.".eslintrc.json".source = ./.eslintrc.json;
  
  home.packages = with pkgs; [
    nodePackages.eslint
    nodePackages.eslint-plugin-react
  ];
}
```

## Assets Management

Assets are organized by type:

```nix
# Module that installs company fonts
{ config, lib, pkgs, ... }:

{
  fonts.packages = [
    (pkgs.callPackage ../../../overlays/custom-font.nix {})
  ];

  # Copy company brand assets to the correct location
  home.file.".local/share/company/branding" = {
    source = ../../../assets/images/branding;
    recursive = true;
  };
}
```

## Configuration Files

Complex configuration files are managed via home-manager:

```nix
# home/modules/desktop/hyprland.nix
{ config, lib, pkgs, ... }:

with lib;
let 
  cfg = config.myHome.desktop.hyprland;
in {
  options.myHome.desktop.hyprland = {
    enable = mkEnableOption "Hyprland window manager";
    theme = mkOption {
      type = types.enum [ "dark" "light" ];
      default = "dark";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.enable = true;
    
    # Configuration files
    xdg.configFile = {
      "hypr/hyprland.conf".text = ''
        # Generated Hyprland config
        monitor=eDP-1,1920x1080@60,0x0,1
        
        # Theme selection
        source = ~/.config/hypr/themes/${cfg.theme}.conf
      '';
      
      # Theme file
      "hypr/themes/${cfg.theme}.conf".source = 
        ../../../assets/hyprland/themes + "/${cfg.theme}.conf";
        
      # Scripts directory
      "hypr/scripts" = {
        source = ../../../assets/hyprland/scripts;
        recursive = true;
      };
    };
  };
}
```

## Entry Point

The main flake.nix serves as central control:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./flakeModules ];
      
      systems = [ "x86_64-linux" "aarch64-linux" ];
      
      flake = {
        nixosConfigurations = {
          "machine-name" = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              ./hosts/machine-name
              inputs.home-manager.nixosModules.home-manager
              { 
                home-manager.users.username.imports = [
                  ./home/profiles/developer.nix
                ]; 
              }
              ./users/username.nix
              ./env/default.nix
            ];
          };
        };
        
        # Export development flakes
        devFlakes = {
          webStack = ./dev/flakes/web-stack;
          dataScience = ./dev/flakes/data-science;
        };
      };
    };
}
```

## Environment Variables

Management of global and user-specific environment variables:

```nix
# env/default.nix
{
  environment.variables = {
    COMPANY_NAME = "StartupNix";
    EDITOR = "nvim";
  };
}

# env/users/username.nix
{
  home-manager.users.username.home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk11}";
    NODE_PATH = "${pkgs.nodejs}/lib/node_modules";
  };
}
```

## Deployment and Usage

1. **Clone repository**: `git clone git@github.com:company/nix-config.git`
2. **Switch to configuration**: `sudo nixos-rebuild switch --flake .#machine-name`
3. **Activate dev environment**: `nix develop .#webStack`

## Best Practices

1. **Module options**: Define clear options for all modules
2. **Parameterization**: Make everything configurable
3. **Documentation**: Document options and module purpose
4. **Testing**: Test configurations before deployment
5. **Version control**: Track changes to configuration
6. **Secret management**: Keep secrets encrypted

## Attribution

- Pablo Aguirre

## References

- TODO:Add references
