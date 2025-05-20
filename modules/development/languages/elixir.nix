# modules/development/languages/elixir.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.elixir;
in
{
  options.rhodium.system.development.languages.elixir = {
    enable = mkEnableOption "Enable Elixir development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Elixir (includes Mix)
      elixir

      # Erlang (Elixir dependency)
      erlang # Ensure this is compatible with the Elixir version

      # Language Server
      elixir-ls

      # Optional: Phoenix framework installer
      # phx_new # (Check for current package name if needed)
    ];
  };
}
