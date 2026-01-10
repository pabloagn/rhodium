{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.userExtraServices.rh-astal;
  astalPkg = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.astal-widgets;
in
{
  options.userExtraServices.rh-astal = {
    enable = lib.mkEnableOption "Enable Astal widgets";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ astalPkg ];

    systemd.user.services.rh-astal = {
      Unit = {
        Description = "Astal Widgets";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Environment = [ "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin" ];
        ExecStart = "${astalPkg}/bin/astal-widgets";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
