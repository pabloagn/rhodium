# modules/development/languages/erlang.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.erlang;
in
{
  options.rhodium.system.development.languages.erlang = {
    enable = mkEnableOption "Enable Erlang development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Erlang OTP
      erlang

      # Build Tool
      rebar3

      # Language Server
      erlang_ls
    ];
  };
}
