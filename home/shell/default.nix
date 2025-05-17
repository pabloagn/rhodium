# home/shell/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell;
in
{
  imports = [
    ./shells
    ./prompts
    ./common
  ];

  options.rhodium.shell = {
    enable = mkEnableOption "Rhodium's shell configuration";

    shells = mkOption {
      description = "Shell-specific configurations";
      default = {};
    };

    prompts = mkOption {
      description = "Prompt-specific configurations";
      default = {};
    };
  };
}
