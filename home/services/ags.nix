{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.userExtraServices.rh-ags;
in {
  options.userExtraServices.rh-ags = {
    enable = mkEnableOption "AGS (Aylur's GTK Shell) systemd service";
  };
  
  config = mkIf cfg.enable {
    systemd.user.services.rh-ags = {
      Unit = {
        Description = "AGS (Aylur's GTK Shell) - Astal widget system";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      
      Service = {
        Environment = [
          "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
        ];
        
        # Main service - AGS run command
        ExecStart = "${inputs.ags.packages.${config.nixpkgs.system}.default}/bin/ags run";
        
        # Stop AGS
        ExecStop = "${inputs.ags.packages.${config.nixpkgs.system}.default}/bin/ags quit";
        
        Restart = "on-failure";
        RestartSec = "2";
        KillMode = "mixed";
        Type = "simple";
      };
      
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
