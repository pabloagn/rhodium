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

    # External (Keychron) layout
    configFile = mkOption {
      type = types.path;
      default =
        config.home.homeDirectory
        + "/.config/kmonad/keychron.kbd";
      description = ''
        Absolute path of the *.kbd* file used for the external keyboard.
      '';
    };

    # Internal (laptop-keyboard) layout
    internalConfigFile = mkOption {
      type = types.path;
      default =
        config.home.homeDirectory
        + "/.config/kmonad/justine.kbd";
      description = ''
        Absolute path of the *.kbd* file used for the built-in keyboard.
      '';
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Additional CLI arguments passed to kmonad.";
    };
  };

  config = mkIf cfg.enable {
    # we need the binary
    home.packages = [pkgs.kmonad];

    # ── Keychron ───────────────────────────────────────────────
    systemd.user.services.rh-kmonad-keychron = {
      Unit = {
        Description = "K-Monad - Keychron";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.kmonad}/bin/kmonad \
            ${cfg.configFile} \
            ${lib.concatStringsSep " " cfg.extraArgs}
        '';
        Restart = "on-failure";
        RestartSec = 1;
        Nice = "-5";
      };
      Install = {WantedBy = ["graphical-session.target"];};
    };

    # ── Justine ────────────────────────────────────────────
    systemd.user.services.rh-kmonad-justine = {
      Unit = {
        Description = "K-Monad - Justine";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.kmonad}/bin/kmonad \
            ${cfg.internalConfigFile} \
            ${lib.concatStringsSep " " cfg.extraArgs}
        '';
        Restart = "on-failure";
        RestartSec = 1;
        Nice = "-5";
      };
      Install = {WantedBy = ["graphical-session.target"];};
    };
  };
}
