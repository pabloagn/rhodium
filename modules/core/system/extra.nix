# modules/core/system/extra.nix

{ lib, config, pkgs, modulesPath, hostData,... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault hostData.platform;
}
