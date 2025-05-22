# home/apps/terminal/emulators/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} configurations" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    foot.enable = false;
    ghostty.enable = false;
    kitty.enable = false;
    st.enable = false;
    wezterm.enable = false;
  };
}
