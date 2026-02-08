{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.extraServices.avahi;
in
{
  options.extraServices.avahi = {
    enable = mkEnableOption "Avahi mDNS/DNS-SD daemon for network service discovery";
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      ipv4 = true;
      ipv6 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
      };
    };
  };
}
