# home/apps/terminal/emulators/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminal.emulators;
in
{
  imports = [
    ./foot.nix
    ./ghostty.nix
    ./kitty.nix
    ./st.nix
    ./wezterm.nix
  ];

  options.rhodium.apps.terminal.emulators = {
    enable = mkEnableOption "Rhodium's terminal emulators";
  };

  config = mkIf cfg.enable {
    rhodium.apps.terminal.emulators.foot.enable = false;
    rhodium.apps.terminal.emulators.ghostty.enable = true;
    rhodium.apps.terminal.emulators.kitty.enable = true;
    rhodium.apps.terminal.emulators.st.enable = false;
    rhodium.apps.terminal.emulators.wezterm.enable = false;
  };
}
