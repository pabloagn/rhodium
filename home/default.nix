# home/default.nix

{ lib, config, pkgs, flakeOutputs, ... }:

let
  flakeRoot = flakeOutputs.self;
in
{
  home.stateVersion = "24.11";
}
