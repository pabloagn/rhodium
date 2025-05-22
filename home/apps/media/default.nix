# home/apps/media/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Media applications";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    audio.enable = false;
    automations.enable = false;
    books.enable = false;
    image.enable = false;
    torrent.enable = false;
    video.enable = false;
  };
}
