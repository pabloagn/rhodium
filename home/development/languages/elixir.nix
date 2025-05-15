{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.elixir;
in
{
  options.home.development.languages.elixir = {
    enable = mkEnableOption "Enable Elixir development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
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
