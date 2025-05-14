{
  users = [
    {
      name = "pabloagn";
      description = "Pablo Aguirre";
      shell = "zsh";
      roles = [ "admin" "developer" ];
      hosts = [ "nixos-wsl2" "nixos-native" ];
      # Optional fields could include:
      # hashedPassword = "..."; # For password setting
      # extraPackages = [ pkgs.vscode pkgs.jetbrains.idea ]; # User-specific packages
      # homeConfig = {}; # Additional home-manager config
    }
    {
      name = "nixos";
      description = "NixOS User";
      shell = "zsh";
      roles = [ "admin" ];
      hosts = [ "nixos-wsl2" "nixos-native" ];
    }
  ];
}
