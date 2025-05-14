# users/pabloagn.nix

# { config, pkgs, lib, hostname, ... }:

# {
#   # Only activate this user on specific hosts
#   config = lib.mkIf (builtins.elem hostname [ "nixos-wsl2" "nixos-native" ]) {
#     # Basic user definition
#     users.users.pabloagn = {
#       isNormalUser = true;
#       description = "Pablo Aguirre";
#       extraGroups = [ "wheel" "networkmanager" "docker" "adbusers" ];
#       shell = pkgs.zsh;
#     };

#     # Home Manager configuration for this user
#     home-manager.users.pabloagn = { ... }: {
#       imports = [ ../home/profiles/developer.nix ];
#       programs.zsh.enable = true;
#     };
#   };
# }

# This function receives arguments passed from home-manager.users.<name> in lib/default.nix
{ inputs, pkgs, lib, rhodium, config, currentUser, userConfig, ... }: {
  # rhodium gives access to flakeOutputs.rhodium (e.g., rhodium.home.profiles)
  # currentUser is the username string, e.g., "pabloagn"
  # userConfig is the attribute set for this user from the host manifest

  imports = [
    # Import the main desktop profile for Home Manager
    rhodium.home.profiles.desktop

    # You can add other common profiles or features for this user here
    # rhodium.home.profiles.developer # If pabloagn is also a developer
  ];

  # Standard Home Manager settings
  home = {
    username = currentUser; # "pabloagn"
    homeDirectory = "/home/${currentUser}";

    # This is important! Set it to the version of Home Manager you're using.
    stateVersion = "24.11"; # Or your current version (e.g., "24.05")
  };

  # User-specific configurations
  programs.git = {
    enable = true;
    userName = "pabloagn";
    userEmail = "PENDING"; # TODO: Add email
  };

  # Example: User-specific theme override or preference
  # This would require your theming system to support such options.
  # rhodium.theme.accentColor = "blue";

  # You can add any other Home Manager options here that are specific to 'pabloagn'
  # across all systems where this user configuration is imported.
}
