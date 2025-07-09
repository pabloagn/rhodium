{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.userExtraServices.rh-kmonad;
in {
  options.userExtraServices.rh-kmonad = {
    enable = mkEnableOption "Keyboard remapping with K-Monad";
    configFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/menus.kbd";
      description = ''
        Absolute path of the *.kbd* file to run.
        You can override this per-host if you keep several layouts.
      '';
    };
    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Additional arguments passed to kmonad.";
    };
  };

  config = mkIf cfg.enable {
    # Make sure the binary is available
    home.packages = [pkgs.kmonad];

    # systemd-user service
    systemd.user.services.rh-kmonad = {
      Unit = {
        Description = "K-Monad keyboard remapper";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.kmonad}/bin/kmonad \
            ${cfg.configFile} \
            ${concatStringsSep " " cfg.extraArgs}
        '';
        Restart = "on-failure";
        RestartSec = 1;
        Nice = "-5"; # Give it a bit of priority
      };

      Install = {WantedBy = ["graphical-session.target"];};
    };

    assertions = [
      {
        assertion = builtins.elem "input" config.users.users.${config.home.username}.extraGroups;
        message = "rh-kmonad: add your user to the 'input' group.";
      }
      {
        assertion = builtins.elem "uinput" config.users.users.${config.home.username}.extraGroups;
        message = "rh-kmonad: add your user to the 'uinput' group.";
      }
    ];
  };
}
