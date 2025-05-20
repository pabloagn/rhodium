# modules/development/languages/default.nix

{ config, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages;
in
{
  imports = [
    ./c.nix
    ./dotnet.nix
    ./html.nix
    ./nix.nix
    ./scala.nix
    ./clojure.nix
    ./elixir.nix
    ./java.nix
    ./nodejs.nix
    ./scheme.nix
    ./common-lisp.nix
    ./elm.nix
    ./javascript.nix
    ./ocaml.nix
    ./sql.nix
    ./cpp.nix
    ./erlang.nix
    ./julia.nix
    ./python.nix
    ./swift.nix
    ./cs.nix
    ./fs.nix
    ./kotlin.nix
    ./r.nix
    ./typescript.nix
    ./css.nix
    ./go.nix
    ./lua.nix
    ./reactjs.nix
    ./zig.nix
  ];

  options.rhodium.system.development.languages = {
    enable = mkEnableOption "Language defaults";
  };

  config = mkIf cfg.enable {
    rhodium.system.development.languages = {
      c.enable = true;
      cpp.enable = true;
      python.enable = true;
      nix.enable = true;
    };
  };
}
