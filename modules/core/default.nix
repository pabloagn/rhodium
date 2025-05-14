# modules/core/default.nix

{
  imports = [
    ./boot.nix
    ./security.nix # Basic security
    ./shells/default.nix
    # ./filesystem/default.nix # If you have one
    # ./networking/default.nix # If you have one, else covered by host config

    ../system-profiles/options.nix # Define the global "props"
  ];
}
