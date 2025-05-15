# modules/development/languages/erlang.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.erlang;
in
{
  options.modules.development.languages.erlang = {
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
