# home/apps/terminals/emulators/default.nix

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

  config = mkIf cfg.enable { };
}
