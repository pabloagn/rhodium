# home/apps/terminal/emulators/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.emulators;
in
{
  imports = [
    ./foot.nix
    ./ghostty.nix
    ./kitty.nix
    ./st.nix
    ./wezterm.nix
  ];

  options.rhodium.home.apps.terminal.emulators = {
    enable = mkEnableOption "Rhodium's terminal emulators";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.terminal.emulators.foot.enable = false;
    rhodium.home.apps.terminal.emulators.ghostty.enable = true;
    rhodium.home.apps.terminal.emulators.kitty.enable = true;
    rhodium.home.apps.terminal.emulators.st.enable = false;
    rhodium.home.apps.terminal.emulators.wezterm.enable = false;
  };
}
