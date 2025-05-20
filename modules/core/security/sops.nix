# modules/core/security/sops.nix

{ config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.rhodium.system.core.security.sops;
in
{
  options.rhodium.system.core.security.sops = {
    enable = mkEnableOption "Enable sops-nix for system secrets";
  };

  # TODO
  config = mkIf cfg.enable {
    sops.secrets.my_secret_key = { };
    sops.secrets.another_secret_file = {
      path = "/etc/my-app/secret.conf";
      owner = "my-app-user";
    };
  };
}
