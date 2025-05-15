# home/development/languages/erlang.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.erlang;
in
{
  options.home.development.languages.erlang = {
    enable = mkEnableOption "Enable Erlang development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Erlang OTP
      erlang

      # Build Tool
      rebar3

      # Language Server
      erlang_ls
    ];
  };
}
