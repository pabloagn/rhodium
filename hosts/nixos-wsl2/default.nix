# hosts/nixos-wsl/default.nix

{ config, pkgs, lib, hostname, ... }: # hostname is from specialArgs in flake.nix

{
  imports = [ ../common/default.nix ];

  networking.hostName = hostname;
  boot.isContainer = true;
  system.stateVersion = "23.11";

  # WSL specific packages or settings
  environment.systemPackages = [ pkgs.wslu ];

  # Set default values for options if this host type always has certain features
  # These can be overridden by the `extraSystemOptions` in flake.nix for a specific instance.
  mySystem.hostProfile = lib.mkDefault "headless-dev";
}
